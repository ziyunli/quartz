---
tags:
  - LLM
  - Architecture
---

> [!info] AI-assisted annotations
> Research compiled and structured with Claude Opus 4.6 via Claude Code. Sources: DeepSeek-V2 paper ([arXiv:2405.04434](https://arxiv.org/abs/2405.04434)), DeepSeek-V3 paper ([arXiv:2412.19437](https://arxiv.org/abs/2412.19437)).

## Why MoE Matters

The core insight is **parameter-compute decoupling**. A dense model's compute scales linearly with its parameter count — doubling parameters doubles FLOPs per token. In a sparse MoE model, you can scale parameters (model capacity, knowledge storage) without scaling per-token compute.

DeepSeek-V3 has 671B parameters but only 37B activate per token — roughly 5.5% of weights fire for any given forward pass. It approaches GPT-4-class capability at roughly the compute cost of a ~37B dense model per token.

The tradeoff: MoE models require more total GPU memory to load all expert weights, and communication overhead across devices is non-trivial. DeepSeek's architecture innovations directly attack both problems.

## DeepSeek-V2 (236B total / 21B active)

### Multi-Head Latent Attention (MLA)

Standard multi-head attention (MHA) requires caching K and V tensors for every prior token during generation. For a 128K context window, this KV cache becomes the dominant memory bottleneck — not the model weights.

MLA caches a single **compressed latent vector** per token instead of full K/V:

```
c_t^KV = W^DKV · h_t          # down-projection to latent space
k_t^C  = W^UK · c_t^KV        # reconstruct K on the fly
v_t^C  = W^UV · c_t^KV        # reconstruct V on the fly
```

The compression dimension d_c = 512, versus full KV dimension of 128 x 128 = 16,384. Only the latent vector is cached.

**Decoupled RoPE:** Rotary positional embeddings can't be applied inside the compressed representation (it would block the matrix absorption trick). Separate decoupled keys carry RoPE with per-head dimension 64, concatenated with compressed attention.

**Result: 93.3% KV cache reduction** vs. DeepSeek 67B dense baseline, enabling 128K context at tractable memory cost and 5.76x generation throughput increase.

> [!info] MLA vs. GQA
> ==Multi-Query/Grouped-Query Attention compress in the head dimension. MLA compresses in the token dimension via a learned latent projection== — achieving much higher compression (93% vs ~50-75% for GQA) while recovering performance through up-projection at compute time. MLA is strictly more expressive than GQA for the same cache budget.

### DeepSeekMoE

Standard MoE (GShard, Switch Transformer) uses large experts with top-1 or top-2 routing. The coarse granularity limits specialization.

DeepSeekMoE uses **fine-grained segmentation**: many more, smaller experts with higher top-K routing. Same total compute per token, distributed across a finer-grained specialization space.

**Expert structure per MoE layer in V2:**

- 2 **shared experts** (always active for every token)
- 160 **routed experts** (top-6 selected per token)
- Total active per token: 8 experts

> [!question] Why shared experts?
> Some knowledge (common linguistic patterns, basic reasoning scaffolding) is universally needed. Forcing this into the routing competition wastes capacity. ==Dedicated shared experts handle universal knowledge; routed experts specialize on domains and token types.==

**Device-limited routing:** Each token routes to experts on at most 3 devices, preventing all-to-all communication that would dominate inference latency.

**V2 overall:** 60 transformer layers, 8.1T training tokens, 42.5% training cost reduction vs. DeepSeek 67B dense baseline despite stronger performance.

## DeepSeek-V3 (671B total / 37B active)

### Scale-up from V2

| Spec             | V2    | V3    |
| ---------------- | ----- | ----- |
| Total parameters | 236B  | 671B  |
| Active per token | 21B   | 37B   |
| Layers           | 60    | 61    |
| Hidden dim       | 5,120 | 7,168 |
| Shared experts   | 2     | 1     |
| Routed experts   | 160   | 256   |
| Top-K routed     | 6     | 8     |

First 3 layers in V3 use dense FFN; layers 4-61 use MoE.

### Auxiliary-Loss-Free Load Balancing

V2's auxiliary balance losses directly compete with the language modeling objective — the model is penalized for routing to the most capable expert if that expert is already "full."

V3 introduces per-expert **bias terms** added to affinity scores only for routing decisions, not for gating weights:

```
routing score = s_{i,t} + b_i    # biased for routing decision
gating weight = softmax(s_{i,t}) # original scores, no bias
```

Bias terms adjust each step: overloaded expert's bias decreases, underloaded increases. The language model loss is never contaminated by a balance penalty.

> [!info] Why this matters
> ==The gating values that weight expert outputs still come from un-biased affinity scores. Only the discrete routing decision uses biased scores.== No token-dropping during training or inference — every token reaches its routed experts.

### Multi-Token Prediction (MTP)

Beyond the main model head, V3 trains D=1 additional sequential prediction modules. Each token predicts 2 tokens total (next + next+1), providing denser gradient signal per training token.

At inference, MTP modules can be discarded entirely or repurposed for **speculative decoding** (propose a candidate token that the main model verifies in one pass).

### FP8 Mixed Precision Training

First validation of FP8 training at 671B scale.

**In FP8:** All linear operation matrix multiplications (attention projections, FFN/expert layers).
**In BF16/FP32:** Embeddings, output head, MoE gating, normalization, softmax, master weights, optimizer states.

Key innovation: **fine-grained quantization** — activations quantized at 1x128 tile granularity, weights at 128x128 block granularity. Prevents outlier values from degrading precision across entire tensors.

### Training Cost

- 2,048 NVIDIA H800 GPUs, 14.8T tokens
- Pre-training: $5.328M (2,664K GPU hours)
- Context extension: $0.238M (119K GPU hours)
- Post-training: $0.01M (5K GPU hours)
- **Total: ~$5.6M, no loss spikes, no training rollbacks**

For comparison: Llama 3.1 405B required ~30.8M GPU hours — roughly 11x more compute for a less capable model.[^1]

[^1]: [Andrej Karpathy](https://x.com/karpathy/status/1872362712958906460)
