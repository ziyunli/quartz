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

DeepSeek open-sources all models under permissive licenses (MIT for R1, custom for V3). This has become a hallmark of the Chinese AI sector more broadly.

Key dynamics (from The Economist's Drumtower podcast "China's DeepSeek Year"):

- **Talent play:** Chinese labs let researchers publish papers and share models openly, attracting talent. American labs are more secretive about breakthroughs, which is less appealing for researchers who want to show their work.
- **Diffusion over dominance:** China's government priority is AI diffusion — getting AI embedded across the economy. The US focuses on model-level dominance. Open-source accelerates diffusion.
- **Startup economics:** Open-source eliminates API cost risk. If your app goes viral, you don't rack up millions in inference fees. This lowers the cost of trial and error, encouraging experimentation.
- **Enterprise adoption:** Banks and regulated industries can't send customer data to external APIs. Open-source models you can run on-premises are the only option, regardless of geopolitics.
- **Platform incumbents benefit most:** Tech giants like Tencent (WeChat) benefit from integrating open-source models into existing user bases, while the startups that built the models struggle to monetize — similar to how Apple saved on CapEx by loading others' AI into iPhones.
- **Z.ai's model (01.ai):** Open-source the model, monetize through hosted API access, national-level collaborations (countries fine-tuning on their data), and coding agent subscriptions.

## Geopolitical Context

<!-- TODO: integrate notes on chip export bans, US-China AI competition -->

The 2022 US ban on NVIDIA A100 exports to China is central to understanding DeepSeek's efficiency focus. Their architectural innovations (MoE, MLA, FP8) are partly a response to compute constraints.

## Distillation Controversy

**January 2025 (press statement):** Microsoft's security team detected unusual account activity in fall 2024 — accounts possibly linked to DeepSeek pulling large amounts of data through OpenAI's API. Both companies blocked those accounts. OpenAI stated: _"We know PRC based companies — and others — are constantly trying to distill the models of leading US AI companies."_ This was reported by the Financial Times and Bloomberg on January 29, 2025 — not a formal blog post.

**February 2026 (OpenAI memo):** OpenAI submitted ["Updated Stakes for American-Led, Democratic AI"](https://assets.bwbx.io/documents/users/iqjWHBFdfxIU/rRmql_jJcxb4/v0) to the US House Select Committee, claiming DeepSeek "continued to pursue activities consistent with adversarial distillation" and that DeepSeek employees developed methods to circumvent access restrictions via obfuscated third-party routers.

**February 2026 (Anthropic blog post):** Anthropic published ["Detecting and preventing distillation attacks"](https://www.anthropic.com/news/detecting-and-preventing-distillation-attacks), alleging DeepSeek, Moonshot (Kimi), and MiniMax used ~24,000 fraudulent accounts generating over 16 million exchanges to extract Claude's capabilities. DeepSeek's portion: 150,000+ exchanges targeting reasoning capabilities and censorship-safe alternatives to policy-sensitive queries.

[^karpathy]: [Andrej Karpathy](https://x.com/karpathy/status/1872362712958906460)
