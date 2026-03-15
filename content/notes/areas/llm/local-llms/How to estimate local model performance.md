---
title: How to estimate local model performance
tags:
  - AI
  - LLM
  - Hardware
created: 2026-03-13
draft: true
---

> [!info] AI-assisted annotations
> Research synthesis and formula verification with Claude Opus 4.6 via Claude Code. Based on community discussion from [HN: Can I run AI locally?](https://news.ycombinator.com/item?id=47363754) (2026-03-13), cross-referenced with published sources.

You don't need a website to estimate whether a model will run well on your hardware. The math is simple once you understand one key insight: ==at batch size 1, LLM token generation is almost entirely memory-bandwidth bound, not compute bound.==

The GPU spends nearly all its time waiting for weights to transfer from memory, not computing. Each token requires reading the model weights once but performs only ~2 FLOPs per parameter. On an A100 (312 TFLOPS, 1.5 TB/s bandwidth), you'd need a batch size of ~208 before compute becomes the bottleneck.[^kipply]

Everything below follows from this single fact.

## Step 1: Does the model fit in memory?

If the model doesn't fit entirely in GPU or unified memory, layers spill to CPU RAM over PCIe (~32 GB/s for Gen4, ~64 GB/s for Gen5) — a 15-60x bandwidth penalty compared to GPU HBM or unified memory.[^kipply] Partial offloading works but each CPU layer adds proportional latency.

Total memory required:

```
total_memory = model_weights + kv_cache + overhead

model_weights = total_params × bits_per_weight / 8
overhead      ≈ 10-20% of model_weights
```

**All parameters must be in memory, even for MoE models.** You can't predict which experts will be needed.[^moe-blog]

### KV cache

The KV cache stores attention state for all tokens in the context window and grows linearly with context length:

```
kv_cache_per_token = 2 × n_layers × n_kv_heads × head_dim × bytes_per_element
kv_cache_total     = kv_cache_per_token × context_length
```

Where:

- `2` — one each for keys and values
- `n_kv_heads` — the number of KV heads, which varies by attention type:
  - **MHA** (multi-head attention): `n_kv_heads = n_attention_heads` (e.g., 64)
  - **GQA** (grouped query attention, used in Llama 2/3): `n_kv_heads` is much smaller (e.g., 8), giving an 8x cache reduction
  - **MQA** (multi-query attention): `n_kv_heads = 1`
- `bytes_per_element` — 2 for fp16/bf16, but quantized KV caches at int4 (0.5) or int8 (1) are supported in frameworks like HuggingFace Transformers[^hf-cache]

**Worked example (Llama-2-70B with GQA):** `2 × 80 layers × 8 kv_heads × 128 dim × 2 bytes = ~320 KB per token`. At 4K context: ~1.3 GB. At 128K context: ~41 GB.[^cursor]

==Reducing context length is one of the most effective ways to fit larger models.== If you only need 16K context instead of 128K, the KV cache shrinks 8x.

## Step 2: How fast will it generate?

```
tok/s ≈ memory_bandwidth / bytes_read_per_token
```

For **dense models**, every parameter is read for every token:

```
bytes_per_token = total_params × bits_per_weight / 8
```

For **MoE models**, only shared layers + activated experts are read per token:

```
bytes_per_token = active_params × bits_per_weight / 8
```

This is why tools like canirun.ai dramatically underestimate MoE performance — they use total params instead of active params in the bandwidth calculation, producing errors of 10-25x.[^hn-thread]

**Speed tiers (subjective):**

- 30+ tok/s — comfortable, conversational
- 10-30 tok/s — usable, noticeable wait on long outputs
- 5-10 tok/s — sluggish but tolerable for batch processing
- <5 tok/s — painful for interactive use

### Prefill is different

Prompt processing (prefill) is **compute-bound**, not memory-bound, because tokens are batched together. A single prompt with 1000 tokens effectively has batch size 1000, saturating GPU compute. This is where Flash Attention matters — FlashAttention-2 achieves 50-73% of theoretical max FLOPs and reduces attention memory from O(N²) to O(N), making long-prompt prefill dramatically faster.[^flash2]

For MoE models, prefill is slower than you'd expect from active params alone: different tokens in the prompt route to different experts, so across the full batch most or all experts get activated. Time-to-first-token on a large MoE can be meaningfully worse than a dense model with the same active parameter count.

## Step 3: How smart is it?

For dense models, quality roughly scales with total parameters (at equivalent training quality and data).

For MoE models, the community uses a rough heuristic:

```
effective_dense_equivalent ≈ sqrt(total_params × active_params)
```

So Qwen3.5-122B-A10B ≈ 35B dense quality, but generating tokens at 10B dense speed. GPT-OSS-20B (20B total, 3.6B active) ≈ 8.5B dense quality.

> [!warning] Unverified heuristic
> This geometric mean formula circulates in practitioner communities (likely originating from r/LocalLLaMA) but is **not published in any peer-reviewed paper**. The Switch Transformer[^switch] and ST-MoE[^st-moe] papers confirm MoE quality falls between active and total param equivalents, and the geometric mean is a reasonable interpolation — but treat it as a rule of thumb, not a proven law.

What IS established: an MoE model with N total params and K active params outperforms a dense model of K params but underperforms a dense model of N params.[^mixtral]

## Step 4: Quantization tradeoffs

Quantizing weights reduces bytes per parameter, directly increasing tok/s (less data to read from memory) at the cost of model quality.

Concrete perplexity impact (7B model, from llama.cpp benchmarks[^quant]):

| Quant  | Bytes/param | Perplexity increase | Verdict                   |
| ------ | ----------- | ------------------: | ------------------------- |
| Q8_0   | ~1.0        |             +0.0004 | Negligible loss           |
| Q6_K   | ~0.75       |             +0.0044 | Very small loss           |
| Q5_K_M | ~0.65       |             +0.0142 | Small loss                |
| Q4_K_M | ~0.55       |             +0.0535 | Acceptable for most tasks |
| Q3_K_M | ~0.44       |             +0.2437 | Noticeable degradation    |
| Q2_K   | ~0.39       |             +0.8698 | Significant degradation   |

==Q4_K_M is the community sweet spot== — roughly 2x faster than Q8 with modest quality loss. Q2/Q3 quants are rarely worth it; the quality degradation is too steep.

**Mixed-precision quants** (like Unsloth's UD format) keep salient weights (attention projections, first/last layers) at higher bit widths while aggressively quantizing less important weights, achieving better perplexity than uniform quantization at the same average bits per parameter.

## Speculative decoding

Speculative decoding uses a small "draft" model to quickly generate K candidate tokens, then the large model verifies all K in a single forward pass. For a memory-bound dense model, verifying K tokens costs about the same as generating 1 (you read the weights once regardless), yielding up to 2-3x speedups.[^spec-dec]

For MoE models, the benefit is likely much smaller: consecutive speculated tokens probably route to different experts, so verification requires loading more expert weights than single-token generation — eroding the bandwidth savings.

> [!warning] Unverified reasoning
> The claim that speculative decoding doesn't help MoE models is plausible community reasoning but **not confirmed in any published paper**. The original speculative decoding paper[^spec-dec] does not discuss MoE at all.

## Framework choice matters

The inference framework can make a 20-50% throughput difference on identical hardware:

- **llama.cpp** — Optimized for single-machine CPU+GPU inference with excellent quantization support. Best for local use.
- **MLX** — Apple Silicon optimized, leverages unified memory with no CPU-GPU copy penalty. Best for Mac inference.
- **vLLM** — Optimized for serving with PagedAttention (efficient KV cache management) and continuous batching. Better throughput at batch > 1, overkill for single-user local inference.

## Memory bandwidth reference

### Apple Silicon

| Chip     | Bandwidth | Max unified memory |
| -------- | --------: | -----------------: |
| M1       |   68 GB/s |              16 GB |
| M1 Pro   |  200 GB/s |              32 GB |
| M1 Max   |  400 GB/s |              64 GB |
| M2       |  100 GB/s |              24 GB |
| M2 Pro   |  200 GB/s |              32 GB |
| M2 Max   |  400 GB/s |              96 GB |
| M3       |  100 GB/s |              24 GB |
| M3 Pro   |  150 GB/s |              36 GB |
| M3 Max   |  400 GB/s |             128 GB |
| M3 Ultra |  800 GB/s |             256 GB |
| M4       |  120 GB/s |              32 GB |
| M4 Pro   |  273 GB/s |              48 GB |
| M4 Max   |  546 GB/s |             128 GB |

Source: Apple Newsroom[^apple-m4][^apple-m2]

### AMD

| Chip                           | Bandwidth |                         Memory |
| ------------------------------ | --------: | -----------------------------: |
| Ryzen AI Max+ 395 (Strix Halo) | ~256 GB/s | Up to 128 GB unified (LPDDR5X) |

Strix Halo supports dynamic GPU memory allocation on Linux — set BIOS dedicated VRAM to 512 MB, use kernel params for the rest. Functionally identical to Apple's unified memory.

### Discrete GPUs

| GPU          |   Bandwidth |  VRAM |
| ------------ | ----------: | ----: |
| RTX 3090     |    936 GB/s | 24 GB |
| RTX 4090     |  1,008 GB/s | 24 GB |
| RTX 5090     | ~1,792 GB/s | 32 GB |
| RTX Pro 6000 | ~1,792 GB/s | 96 GB |
| RX 6800 XT   |    512 GB/s | 16 GB |
| RX 9070      |    608 GB/s | 16 GB |

### Desktop RAM (CPU offloading)

| Type      | Bandwidth (dual-channel) |
| --------- | -----------------------: |
| DDR4-3200 |                 ~51 GB/s |
| DDR5-5600 |                 ~90 GB/s |
| DDR5-6400 |                ~102 GB/s |

These are theoretical peaks; real-world throughput is typically 70-85% of theoretical.

## Worked example

**Question:** Can I run Qwen3.5-122B-A10B on an M4 Max with 128GB?

```
Step 1 — Memory:
  weights = 122B × 4 bits / 8 = ~61 GB (at Q4)
  kv_cache at 32K context ≈ ~4 GB (estimate)
  overhead ≈ ~9 GB
  total ≈ 74 GB → fits in 128 GB ✓

Step 2 — Speed:
  active weights at Q4 = 10B × 4 / 8 = 5 GB
  tok/s ≈ 546 GB/s / 5 GB ≈ ~109 tok/s (theoretical)
  real-world efficiency ~60-70% → ~65-76 tok/s ✓✓

Step 3 — Quality:
  sqrt(122B × 10B) ≈ 35B dense equivalent (heuristic)
  Competitive with best 30-40B dense models.
```

Result: excellent fit. Fast generation, good quality, plenty of memory headroom. See [[Running Local LLM]] for real-world benchmarks that corroborate these estimates, and [[My AI Home Lab]] for a practical M4 Pro 64GB setup.

## References

[^kipply]: Kipply (2022), [Transformer Inference Arithmetic](https://kipp.ly/transformer-inference-arithmetic/) — Definitive explanation of the roofline model for transformer inference.

[^cursor]: Cursor Blog, [Llama Inference](https://www.cursor.com/blog/llama-inference) — Practical worked examples with Llama-2-70B showing compute-bound prefill vs memory-bound generation.

[^finbarr]: Finbarr Timbers (2023), [How is LLaMA.cpp possible?](https://finbarr.ca/how-is-llama-cpp-possible/) — Why quantized models on CPUs achieve reasonable performance.

[^mixtral]: Jiang et al. (2024), [Mixtral of Experts (arXiv:2401.04088)](https://arxiv.org/abs/2401.04088) — "Each token has access to 47B parameters, but only uses 13B active parameters during inference."

[^moe-blog]: HuggingFace, [Mixture of Experts Explained](https://huggingface.co/blog/moe) — All parameters must be in RAM; inference compute scales with active parameters.

[^switch]: Fedus et al. (2021), [Switch Transformers (arXiv:2101.03961)](https://arxiv.org/abs/2101.03961) — MoE scaling analysis.

[^st-moe]: Zoph et al. (2022), [ST-MoE (arXiv:2202.08906)](https://arxiv.org/abs/2202.08906) — 269B sparse model comparable to 32B dense encoder-decoder.

[^flash2]: Dao (2023), [FlashAttention-2 (arXiv:2307.08691)](https://arxiv.org/abs/2307.08691) — 50-73% of theoretical max FLOPs, O(N) memory.

[^spec-dec]: Leviathan et al. (2022), [Fast Inference from Transformers via Speculative Decoding (arXiv:2211.17192)](https://arxiv.org/abs/2211.17192) — 2-3x speedups on dense models; does not discuss MoE.

[^quant]: llama.cpp, [Quantization Quality Comparison (Discussion #2094)](https://github.com/ggerganov/llama.cpp/discussions/2094) — Perplexity benchmarks across GGUF quantization levels.

[^hf-cache]: HuggingFace, [KV Cache Strategies](https://huggingface.co/docs/transformers/main/en/kv_cache) — QuantizedCache, DynamicCache, prefix caching.

[^apple-m4]: Apple Newsroom (2024), [Apple introduces M4 Pro and M4 Max](https://www.apple.com/newsroom/2024/10/apple-introduces-m4-pro-and-m4-max/).

[^apple-m2]: Apple Newsroom (2022), [Apple unveils M2](https://www.apple.com/newsroom/2022/06/apple-unveils-m2-with-breakthrough-performance-and-capabilities/).

[^hn-thread]: Hacker News (2026), [Can I run AI locally? (canirun.ai)](https://news.ycombinator.com/item?id=47363754) — Community discussion exposing canirun.ai's MoE calculation errors.
