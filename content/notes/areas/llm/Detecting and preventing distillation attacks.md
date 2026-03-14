---
tags:
  - Blogmarks
---

> [!info] AI-assisted annotations
> Study notes and discussion callouts with Claude Opus 4.6 via Claude Code.

Anthropic's [February 2026 blog post](https://www.anthropic.com/news/detecting-and-preventing-distillation-attacks) alleging industrial-scale distillation attacks by DeepSeek, Moonshot (Kimi), and MiniMax — 16 million exchanges through ~24,000 fraudulent accounts to extract Claude's capabilities for training their own models.

> [!question] Why would distilled models lack safeguards if Claude already refuses dangerous requests?
> Safety in frontier models operates as ==two separate layers: capabilities (raw knowledge/reasoning from pretraining) and safety training (RLHF, Constitutional AI)==. Distillation copies the capability patterns — how to reason, use tools, code — but safety behaviors aren't structurally embedded in the outputs. Distillers can filter out refusals from training data, fine-tune away residual safety behavior, and simply never add their own safety training. The attack isn't "trick Claude into saying dangerous things" — it's "copy Claude's intelligence and deploy it without the safety wrapper."
>
> The censorship-safe query generation flagged for DeepSeek is a concrete example: they used Claude to help _train away_ content restrictions rather than retain them.
> ^safeguards-gap

> [!info] Further reading on distillation and safety fragility
>
> - **Hinton, Vinyals & Dean (2015) — ["Distilling the Knowledge in a Neural Network"](https://arxiv.org/abs/1503.02531)** — foundational paper on knowledge distillation; a smaller "student" model learns from a larger "teacher" model's output distribution
> - **Qi et al. (2023) — ["Fine-tuning Aligned Language Models Compromises Safety, Even When Users Do Not Intend To"](https://arxiv.org/abs/2310.03693)** — showed that fine-tuning on as few as ~100 examples can strip RLHF safety alignment; the core empirical evidence for why distillation is dangerous
> - **Yang et al. (2023) — ["Shadow Alignment: The Ease of Subverting Safely-Aligned Language Models"](https://arxiv.org/abs/2310.02842)** — demonstrated safety guardrails can be removed with minimal compute and data
>   ^further-reading

> [!question] How do DeepSeek's three techniques map to their known R1 training pipeline?
> Each technique targets a specific bottleneck in R1's four-stage pipeline ([DeepSeek-R1 paper](https://arxiv.org/abs/2501.12948)):
>
> - **CoT extraction → cold-start SFT data.** R1's pipeline starts with a small set of high-quality `(problem, CoT, answer)` triples to initialize reasoning format before RL. The "imagine the internal reasoning behind a completed response" prompt generates exactly these triples at scale. ==The retroactive framing (explain a completed answer, not reason live) produces cleaner training data format.==
> - **Rubric-based grading → reward signal for GRPO.** GRPO generates groups of candidate responses and compares them using reward scores — but doesn't need a separate trained value network. If Claude scores 8-16 responses on a structured rubric, those scores map directly to GRPO's reward inputs. This exploits the same insight as Anthropic's own Constitutional AI / RLAIF ([Bai et al., 2022](https://arxiv.org/abs/2212.08073)): an AI model can substitute for human preference labels. LLM-as-judge achieves >80% agreement with human preferences ([Zheng et al., 2023](https://arxiv.org/abs/2306.05685)).
> - **Censorship-safe alternatives → value alignment training.** This isn't capability distillation — it's _behavior_ distillation. Generates `(sensitive_query → acceptable_deflection)` pairs for training content filtering that steers naturally, rather than brittle keyword filters. The resulting model doesn't lack safety — it has safety _replaced_ with a different value system.
>
> The combination replicates most of a legitimate training pipeline using Claude as the oracle instead of human annotators.
> ^deepseek-pipeline

> [!question] How do you "extract and reconstruct" reasoning traces from a black-box model?
> Three scenarios of increasing difficulty:
>
> - **Model exposes CoT** (DeepSeek R1, QwQ): just collect `<think>` tokens via API at scale
> - **Model can be prompted to emit CoT** (Claude, GPT-4): "let's think step by step," role prompting, ask-then-explain. Microsoft's **Orca** ([Mukherjee et al., 2023](https://arxiv.org/abs/2306.02707)) industrialized this — 5M prompts to GPT-4 with system prompts requiring step-by-step reasoning
> - **Model hides reasoning** (o1-style): use differential prompting (modify the problem, observe how answers change) or a **surrogate model** (e.g., R1) to reconstruct a plausible trace for the target model's output
>
> ==Key finding: [Li et al. (2025)](https://arxiv.org/abs/2502.07374) showed training on reasoning traces with _wrong_ intermediate steps degrades performance by only ~3% vs correct traces, as long as sequential structure is preserved.== This means reconstruction doesn't need to match the original model's computation — just the step-ordered structure. Huge advantage for attackers.
>
> Caveat: [Gudibande et al. (2023)](https://arxiv.org/abs/2305.15717) warned that distilled models mimic the teacher's _style_ without acquiring underlying capability — the "False Promise of Imitating Proprietary LLMs." On out-of-distribution tasks, the gap barely closes.
> ^reasoning-trace-extraction

> [!question] DeepSeek is listed first, but is it really the biggest offender?
> By volume, ==MiniMax accounts for ~81% of total exchanges (13M), Moonshot ~21% (3.4M), and DeepSeek less than 1% (150K)==. DeepSeek is listed first likely for political salience — it's the most recognizable name in the US-China AI competition narrative and already faced OpenAI distillation allegations. Leading with DeepSeek maximizes impact with policymakers and press, even though MiniMax did the heavy lifting volumetrically.
>
> That said, DeepSeek's techniques were arguably more _sophisticated_ — chain-of-thought extraction and censorship-safe query generation are qualitatively different from bulk capability scraping. But Anthropic doesn't make that argument explicitly; they let the ordering and DeepSeek's name recognition do the work. This post appeared in the context of Anthropic lobbying for export controls, and the framing choices serve that goal.
> ^volume-framing

> [!example] Hydra cluster architecture — how it works technically
> A multi-layer infrastructure for API access arbitrage:
>
> - **Account farm (Layer 1):** Thousands of accounts pre-created with different identities, payment methods, and email addresses. Spread across Anthropic's direct API, AWS Bedrock, Google Cloud, and other platforms that resell Claude. When one is banned, another activates immediately.
> - **Proxy gateway (Layer 2):** Central orchestration routes requests across the account pool. Load balancing keeps each account under rate/volume thresholds. Residential proxies or geographically distributed cloud instances mask the true origin. The archived open-source project [LLM-Red-Team/free-api-hub](https://github.com/LLM-Red-Team/free-api-hub) (GitHub, archived Nov 2025) provided Docker Compose configs for one-click deployment of these proxy services with keep-alive pings.
> - **Traffic mixing (Layer 3):** Distillation queries are interleaved with legitimate-looking requests to defeat anomaly detection. Timing is coordinated to mimic organic usage patterns.
>
> ==Detection is essentially Sybil attack detection applied to API abuse== — correlating shared payment methods, synchronized timing, and identical prompt structures across nominally independent accounts.
> ^hydra-cluster

> [!warning] Does distillation actually produce frontier models?
> Comparing the three labs' current models against frontier (Opus 4.6, GPT-5.x) tells a mixed story:
>
> - **MiniMax** ran the largest campaign (13M exchanges, 81% of volume) but M2.5 (229B) ranks 74th on Arena — nowhere near frontier. Their strength is niche: web dev, coding, multimodal (Hailuo video, Speech TTS)
> - **Moonshot/Kimi** (3.4M exchanges) shipped K2.5 — a 1T MoE with 32B active params scoring 96.1 on AIME 2025 and strong agentic benchmarks via "Agent Swarm." Competitive on reasoning/agentic tasks, which is exactly what they targeted in the distillation campaign
> - **DeepSeek** (<150K exchanges) is genuinely frontier-competitive through independent R&D (MoE architecture, GRPO training for R1)
>
> ==The biggest distiller produced the weakest results, suggesting distillation alone doesn't create frontier models== — architectural innovation and training methodology matter far more. Distillation is a **shortcut for capability bootstrapping**, not a path to frontier. Distilled models tend to mimic the teacher's style but struggle on out-of-distribution tasks — they learn surface patterns without underlying reasoning depth (the "imitation gap"). Labs that rely on it heavily can close the gap on yesterday's capabilities but can't lead. MiniMax's Arena ranking (74th) despite 13M exchanges is a clean illustration of this ceiling.
>
> This matters more to **smaller or less research-mature labs** facing a cold start problem — distillation lets them skip figuring out _what good outputs look like_ and go straight to imitation. Labs with massive compute and strong research orgs (Alibaba, DeepSeek's parent High-Flyer) can afford to pretrain from scratch, develop novel architectures, and iterate on their own failures.
>
> **Notable absence: Alibaba (Qwen).** Qwen 3.5 is arguably closer to true frontier (Opus 4.6, GPT-5.2/3/4) than any of the three labs named here, yet Alibaba isn't mentioned. Either Alibaba didn't distill from Claude, or Anthropic didn't detect it, or they chose not to name them. Given Alibaba's massive compute resources and established research org, they may simply not need to distill — they can train from scratch at scale. This raises the question of whether the three named labs were targeted partly because they're easier to frame as bad actors than a major US trading partner's flagship tech conglomerate.
> ^distillation-efficacy
