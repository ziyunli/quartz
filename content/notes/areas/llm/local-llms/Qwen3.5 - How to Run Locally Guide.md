---
title: Qwen3.5 - How to Run Locally Guide
tags:
  - local-llms
created: 2026-03-14
source: https://unsloth.ai/docs/models/qwen3.5
---

> [!info] AI-assisted annotations
> Study notes and HN signal curation for the [Unsloth Qwen3.5 local inference guide](https://unsloth.ai/docs/models/qwen3.5) with Claude Opus 4.6 via Claude Code. HN thread: [How to run Qwen 3.5 locally](https://news.ycombinator.com/item?id=47292522).

> [!info] Overview
> This is Unsloth's cookbook for running Qwen3.5 locally via llama.cpp or LM Studio. It covers every model size from 0.8B to 397B with specific commands for thinking vs non-thinking mode. Qwen3.5 is a family of ==hybrid reasoning models== (thinking + non-thinking) with ==256K context== and ==vision== capabilities. Unsloth provides "Dynamic 2.0" quantized GGUFs that upcast important layers to higher precision. Currently ==no Ollama support== due to separate vision (mmproj) files — must use llama.cpp backends.
> ^overview

## Model Formats & Quantization

> [!question] What is GGUF?
> ==GGUF (GPT-Generated Unified Format) is a single-file binary format for storing quantized LLM weights==, created by the llama.cpp project (replacing the older GGML format). It packages compressed weights, model metadata, tokenizer, and config into one file that llama.cpp and anything built on it (LM Studio, Ollama) can load directly.
>
> Model labs release weights in formats meant for GPU clusters (PyTorch checkpoints, safetensors) — the full Qwen3.5-397B is ~807GB. GGUF is what makes "run it on your laptop" possible. Think of it as: ==safetensors is the distribution format for cloud GPUs, GGUF is the distribution format for local inference.==
> ^gguf

> [!question] Safetensors vs GGUF — what's the real difference?
> **Safetensors** (by HuggingFace): a safe binary format for storing raw tensors. It replaced Python's pickle format because pickle files can execute arbitrary code on load. Safetensors stores ==just the weights== — you still need separate files for tokenizer, model config, etc. It's the standard format on HuggingFace for the Python/PyTorch ecosystem.
>
> **GGUF** (by llama.cpp): a ==self-contained binary== that bundles weights + tokenizer + config + architecture metadata + quantization info all in one file. Designed for llama.cpp's C++ inference engine with memory-mapped loading (the OS pages in chunks on demand instead of loading everything into RAM).
>
> ==The dividing line is the inference stack, not the language:==
>
> - **PyTorch stack** (safetensors): HuggingFace `transformers`, vLLM, TGI — need a proper GPU, full CUDA stack
> - **llama.cpp stack** (GGUF): llama.cpp, Ollama, LM Studio — designed for CPU + optional GPU offload, runs on laptops
>
> (`transformers` is HuggingFace's Python library — the dominant way to load, run, and fine-tune models in the PyTorch ecosystem.)
> ^safetensors-vs-gguf

> [!question] How does Unsloth Dynamic 2.0 quantization work?
> Standard quantization compresses every layer to the same bit-width uniformly. Dynamic 2.0 instead ==measures each layer's sensitivity using KL Divergence== (how much the output distribution shifts when compressed) and ==upcasts sensitive layers to 8-bit or 16-bit while keeping the rest at the target bit-width.==
>
> So a "4-bit" Dynamic GGUF is actually a mix of 4-bit, 8-bit, and 16-bit layers — bigger than naive 4-bit, but measurably closer to original full-precision behavior. The naming convention reflects how aggressively layers get upcasted:
>
> - `UD-Q4_K_XL` — more layers upcasted (bigger file, better quality)
> - `UD-Q4_K_M` — medium upcasting (smaller file, slightly lower quality)
> - Hierarchy: `_XL > _L > _M > _S > _XS`
>
> Methodology: [Dynamic 2.0 docs](https://github.com/unslothai/docs/blob/main/basics/unsloth-dynamic-2.0-ggufs) | Qwen3.5-specific results (150+ KL Divergence tests, 9TB of GGUFs): [GGUF Benchmarks](https://unsloth.ai/docs/models/qwen3.5/gguf-benchmarks)
> ^dynamic-2

> [!question] What is KL Divergence and why does it matter for quantization?
> KL Divergence (Kullback-Leibler Divergence) measures ==how much one probability distribution differs from another==. For quantization benchmarking: feed the same input to the full-precision model and the quantized model, compare their next-token probability distributions. Lower KL Divergence = the quantized model behaves more like the original.
>
> It's a better metric than "does it get the right answer on benchmarks" because it captures ==all the ways the model's behavior shifts==, not just whether the top answer changed. Unsloth uses it per-layer to decide which layers to upcast in Dynamic 2.0 — layers that cause big KL Divergence spikes get more bits.
> ^kl-divergence

## Architecture

> [!question] What is MoE and what does "35B-A3B" mean?
> A **dense** model like 27B has all 27B parameters active for every token. A **Mixture of Experts (MoE)** model splits its feed-forward layers into parallel sub-networks called **experts**. A small ==router network picks which experts to activate== (typically top-2 out of ~64) per token — the rest sit idle. **"35B-A3B" means 35B total parameters, 3B Active per token.**
>
> Why this matters for local inference:
>
> - ==Memory:== need RAM for all 35B params (can't predict which experts are needed)
> - ==Speed:== each token reads only ~3B from memory → much faster tok/s
> - ==Quality:== the model "knows more" than a 3B dense model (trained on 35B params), but each token gets less compute than 27B dense
>
> HN confirms the speed gap: [teaearlgraycold](https://news.ycombinator.com/item?id=47295404) on M3 Air 24GB — "27B is 2 tok/s but 35B A3B is 14-22 tok/s." But [andai](https://news.ycombinator.com/item?id=47340408): "27B does better on benchmarks." The tradeoff is real — MoE trades per-token compute for speed.
>
> Naming convention: **27B** = dense (no "A" suffix), **35B-A3B** / **122B-A10B** / **397B-A17B** = MoE (A = Active params). See [[How to estimate local model performance]] for the quality heuristic: `effective_dense_equivalent ≈ sqrt(total × active)`, so 35B-A3B ≈ ~10B dense quality at 3B dense speed.
>
> Bonus: [zozbot234 on HN](https://news.ycombinator.com/item?id=47295504) notes that with MoE, inactive experts can be streamed from disk via mmap — since most experts aren't needed per token, the SSD penalty is more gradual than with dense models.
> ^moe

## Inference Performance

> [!question] Why does memory bandwidth matter more than VRAM size?
> Fitting the model in memory is necessary but not sufficient. ==At batch size 1, LLM token generation is almost entirely memory-bandwidth bound, not compute bound.== Each token requires reading every weight once (~2 FLOPs per parameter), so the GPU finishes the math almost instantly and sits idle waiting for the next chunk of weights from memory.
>
> Speed formula: `tok/s ≈ memory_bandwidth / bytes_read_per_token`. For MoE models like 35B-A3B, you only read the ==active params (3B)== per token, not the full 35B — that's why it's so much faster than the dense 27B despite being "bigger."
>
> This is why an M1 Max (400 GB/s) beats newer M5 Pro chips on LLM inference — it has a wider memory bus ([spwa4 on HN](https://news.ycombinator.com/item?id=47296378)). But [seanmcdirmid](https://news.ycombinator.com/item?id=47302171) correctly pushes back: "it doesn't matter if you have 1000GB/s bandwidth if you only have 32GB of VRAM" — ==you need both enough memory to fit the model AND enough bandwidth to read it fast.==
>
> See [[How to estimate local model performance]] for formulas, bandwidth reference tables, and worked examples.
> ^mem-bandwidth

> [!question] What is the KV cache and why does it eat your memory?
> When generating token #500, the model needs to attend to all 499 previous tokens. Rather than recompute attention from scratch each time, it ==caches the Key and Value vectors== from every previous token's attention computation. Only the new token's K/V are computed; the rest are looked up.
>
> The KV cache ==grows linearly with context length== and shares the same memory pool as model weights. Formula: `kv_cache_per_token = 2 × n_layers × n_kv_heads × head_dim × bytes_per_element`. At 128K context this can be tens of GB — the hardware table above only accounts for model weights, not context overhead.
>
> You can ==quantize the KV cache itself== to save memory — that's what the `--cache-type-k` and `--cache-type-v` flags do. [vasquez on HN](https://news.ycombinator.com/item?id=47295562): "K is more sensitive to quantization than V, don't bother lowering K past q8_0." And [moffkalast](https://news.ycombinator.com/item?id=47296060): "Smaller models use a smaller KV cache, so longer contexts are more viable" — a 9B model's cache is much smaller than 27B's for the same context length.
>
> See [[How to estimate local model performance#KV cache]] for the full formula and worked examples.
> ^kv-cache

> [!question] What is YaRN?
> **YaRN** (Yet another RoPE extensioN) is a technique for extending a model's context window beyond what it was trained on. Transformers use ==positional encodings== to know where each token sits in the sequence. **RoPE** (Rotary Position Embedding) encodes position by rotating embedding vectors at position-dependent frequencies.
>
> Problem: a model trained on 256K context has only seen positions 1–262,144. At position 500,000, the rotations hit frequencies never encountered during training → output quality degrades. ==YaRN rescales the position encodings== so that even at 1M tokens, the model "sees" frequencies within its trained range — like zooming out a ruler while keeping relative ordering intact.
>
> Caveat: extending context architecturally doesn't mean the model _learned_ long-range attention patterns. The headline context number and the ==usable context number are different things== — quality still degrades at extended lengths ([the_duke on HN](https://news.ycombinator.com/item?id=47296254): "at least 100k context without huge degradation is important for coding tasks").
> ^yarn

## Practical Notes

> [!warning] Ollama caveat: text works, vision doesn't (as of Mar 2026)
> The Unsloth guide says "no Qwen3.5 GGUF works in Ollama" but this is specifically about ==Unsloth's multimodal GGUFs==. Ollama's own registry packages text-only Qwen3.5 models (e.g., `qwen3.5:9b` is Q8_0 per `ollama show`) and those work fine — you just don't get vision. The issue is that Qwen3.5's vision support requires a separate `mmproj-F16.gguf` file (the vision encoder), and Ollama didn't support loading separate mmproj files alongside the main GGUF at time of writing.
>
> HN confirms: multiple users report Qwen3.5 working in Ollama for text/code tasks ([chr15m](https://news.ycombinator.com/item?id=47297526): "27B is absolutely cracked on an RTX 3090"), while [adsharma](https://news.ycombinator.com/item?id=47300202) notes "the ggufs from unsloth don't work with ollama." [KronisLV](https://news.ycombinator.com/item?id=47295745) also hit MoE-specific multi-GPU issues ([ollama#14419](https://github.com/ollama/ollama/issues/14419)).
> ^ollama-caveat

## HN Community Signal

From the [HN discussion](https://news.ycombinator.com/item?id=47292522) (~100 comments):

> [!question] Memory bandwidth is the bottleneck, not VRAM size
> For local LLM inference (especially MoE models), ==memory bandwidth matters more than raw VRAM==. An M1 Max (400 GB/s) beats every M5 chip except the top M5 Max (610 GB/s). NVIDIA's 5090 has 1792 GB/s but caps at 32GB VRAM — so it dominates on small models but can't fit the larger ones. Apple's Ultra chips (800+ GB/s) with 128-192GB unified memory hit the sweet spot for running large models.
> — [spwa4](https://news.ycombinator.com/item?id=47296378), [embedding-shape](https://news.ycombinator.com/item?id=47299118)
> ^hn-bandwidth

> [!question] 35B-A3B is the sweet spot for most people
> 35B-A3B is an MoE model (only 3B params active at inference), so it runs ==~2x faster than the 27B dense model== while being surprisingly competitive. antirez (Redis creator) benchmarked it at ==92.5% of DeepSeek quality== with thinking on. 27B scores slightly higher on SWE-bench and uses less memory, but 35B-A3B is much more usable at interactive speeds. On an M3 Air with 24GB: 27B gets 2 tok/s, 35B-A3B gets 14-22 tok/s.
> — [antirez](https://news.ycombinator.com/item?id=47295836), [teaearlgraycold](https://news.ycombinator.com/item?id=47295404)
> ^hn-sweet-spot

> [!warning] The sycophancy is real and fixable
> Multiple people find Qwen "insufferably sycophantic" — "like 4o dialed up to 20, every reply starts with 'You are absolutely right'." Popular workaround: prefix prompts with `persona: brief rude senior` or `persona: emotionless vulcan`. For structured tasks (JSON output, categorization), adding "do not explain your response" works well.
> — [moffkalast](https://news.ycombinator.com/item?id=47296010), [Anduia](https://news.ycombinator.com/item?id=47296055), [ggregoire](https://news.ycombinator.com/item?id=47297472)
> ^hn-sycophancy

> [!warning] Thinking mode can run away
> Several reports of thinking mode running for minutes on trivial prompts like "hey." The ==`presence_penalty=1.5`== setting from the recommended params is key to controlling this. Some found it wouldn't stop without setting thinking budget to -1. The no-think mode is "much faster and may be more practical for most situations."
> — [jadbox](https://news.ycombinator.com/item?id=47297024), [sammyteee](https://news.ycombinator.com/item?id=47298381), [agile-gift0262](https://news.ycombinator.com/item?id=47306001)
> ^hn-thinking-runaway

> [!warning] Long context degrades differently than SOTA
> Qwen3.5 uses sliding window attention that ==favors more recent context==. At long contexts it can ignore earlier instructions. "I could give them strict instructions to NOT do something and they would follow it for a short time before ignoring my prompt." Also, 35B-A3B's token generation drops from ~25 tok/s to ~12 tok/s at 33K context depth.
> — [Aurornis](https://news.ycombinator.com/item?id=47298855), [d4rkp4ttern](https://news.ycombinator.com/item?id=47296667)
> ^hn-long-context

> [!question] For agentic coding, use Qwen3-Coder instead
> Community consensus: ==qwen3.5 is better for general reasoning and planning; qwen3-coder-next is better for actual file editing and multi-step coding tasks==. "qwen3-coder is better for code generation and editing, strong at multi-file agentic tasks." Several people also found Qwen3.5 gets stuck in loops during agentic use and ignores CLAUDE.md instructions.
> — [andsoitis](https://news.ycombinator.com/item?id=47297266), [badgersnake](https://news.ycombinator.com/item?id=47295783), [jedisct1](https://news.ycombinator.com/item?id=47301401)
> ^hn-qwen-coder

> [!question] Quantization rule of thumb
> ==Larger model at lower quant beats smaller model at higher quant==, with diminishing returns below 3-bit. For models under 70B, don't go below 4-bit. Unsloth's danielhanchen clarified the naming: Q4_K_M and UD-Q4_K_XL are the same approach, just XL is slightly bigger. The naming convention is `_XL > _L > _M > _S > _XS`. Q4_0 and Q4_1 are deprecated (reduced accuracy).
> — [moffkalast](https://news.ycombinator.com/item?id=47296060), [causal](https://news.ycombinator.com/item?id=47299740), [danielhanchen](https://news.ycombinator.com/item?id=47296608)
> ^hn-quant-rule
