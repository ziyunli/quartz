---
tags:
  - LLM
  - Business
---

> [!info] AI-assisted annotations
> Reorganized from monolithic note into topic files with Claude Opus 4.6 via Claude Code.

[DeepSeek](https://github.com/deepseek-ai) is a Chinese AI lab backed by High-Flyer (幻方), a quantitative hedge fund based in Hangzhou. Founded by Liang Wenfeng, it focuses on open-source frontier models built with extreme cost efficiency.

## Models

### V3 (December 2024)

671B MoE model with 37B active parameters per token. Trained for ~$5.6M on 2,048 H800 GPUs — roughly 11x less compute than Llama 3.1 405B for a stronger model.[^karpathy]

API pricing (at launch):

- Input: $0.27/million tokens ($0.07/million with cache hits)
- Output: $1.10/million tokens

Compared to Claude 3.5 Sonnet (as of 20241228): $3/million input, $15/million output.

See [[DeepSeek MoE Architecture]] for the technical innovations (MLA, DeepSeekMoE, auxiliary-loss-free balancing, FP8 training).

### R1 (January 2025)

Reasoning model matching OpenAI o1 performance. Key breakthrough: demonstrated that pure reinforcement learning can produce chain-of-thought reasoning without supervised fine-tuning (R1-Zero).

See [[DeepSeek R1]] for details on GRPO training, the four-stage pipeline, and distilled model variants.

## Company & Culture

See [[DeepSeek as a Company]] for quotes from Chinese-language profiles on their research-first strategy, hiring philosophy, and views on AGI.

## Open-Source Strategy

<!-- TODO: flesh out from podcast notes and other sources -->

DeepSeek open-sources all models under permissive licenses (MIT for R1, custom for V3). This has become a hallmark of the Chinese AI sector — see The Economist's Drumtower podcast "China's DeepSeek Year" for broader context on how open-source drives diffusion and startup innovation in China.

## Geopolitical Context

<!-- TODO: integrate notes on chip export bans, US-China AI competition -->

The 2022 US ban on NVIDIA A100 exports to China is central to understanding DeepSeek's efficiency focus. Their architectural innovations (MoE, MLA, FP8) are partly a response to compute constraints.

## Distillation Controversy

**January 2025 (press statement):** Microsoft's security team detected unusual account activity in fall 2024 — accounts possibly linked to DeepSeek pulling large amounts of data through OpenAI's API. Both companies blocked those accounts. OpenAI stated: _"We know PRC based companies — and others — are constantly trying to distill the models of leading US AI companies."_ This was reported by the Financial Times and Bloomberg on January 29, 2025 — not a formal blog post.

**February 2026 (OpenAI memo):** OpenAI submitted ["Updated Stakes for American-Led, Democratic AI"](https://assets.bwbx.io/documents/users/iqjWHBFdfxIU/rRmql_jJcxb4/v0) to the US House Select Committee, claiming DeepSeek "continued to pursue activities consistent with adversarial distillation" and that DeepSeek employees developed methods to circumvent access restrictions via obfuscated third-party routers.

**February 2026 (Anthropic blog post):** Anthropic published ["Detecting and preventing distillation attacks"](https://www.anthropic.com/news/detecting-and-preventing-distillation-attacks), alleging DeepSeek, Moonshot (Kimi), and MiniMax used ~24,000 fraudulent accounts generating over 16 million exchanges to extract Claude's capabilities. DeepSeek's portion: 150,000+ exchanges targeting reasoning capabilities and censorship-safe alternatives to policy-sensitive queries.

[^karpathy]: [Andrej Karpathy](https://x.com/karpathy/status/1872362712958906460)
