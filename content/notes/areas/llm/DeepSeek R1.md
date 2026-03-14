---
tags:
  - LLM
  - Reasoning
draft: false
---

> [!info] AI-assisted annotations
> Research compiled and structured with Claude Opus 4.6 via Claude Code. Sources: DeepSeek-R1 paper ([arXiv:2501.12948](https://arxiv.org/abs/2501.12948)), [HuggingFace model card](https://huggingface.co/deepseek-ai/DeepSeek-R1).

DeepSeek-R1 is a 671B MoE reasoning model (37B active) released January 20, 2025, under the MIT License. It achieves performance comparable to OpenAI o1-1217 on math, coding, and reasoning benchmarks.

## Key Innovation: RL-Driven Reasoning

The central thesis: **reasoning capabilities can be incentivized through pure reinforcement learning, without human-annotated chain-of-thought demonstrations.**

Training uses **GRPO (Group Relative Policy Optimization)** — compares trajectories within groups rather than maintaining a separate reward model, reducing compute vs. PPO.

Reward design uses two signals:

- **Accuracy rewards**: outcome-based verification (correct/incorrect) for math and code
- **Format rewards**: penalizing outputs that don't use the `<think>...</think>` reasoning format

## R1-Zero: Pure RL Without SFT

R1-Zero starts from DeepSeek-V3-Base and applies RL directly — no supervised fine-tuning, no chain-of-thought seed data.

The model spontaneously developed:

- Extended reasoning chains (the "aha moment": allocating more tokens to harder problems without being told to)
- Self-reflection and verification behaviors
- Dynamic strategy adaptation

> [!question] Why is R1-Zero significant?
> ==It demonstrates reasoning as an economically rational response to problem difficulty under RL optimization== — the model learns that thinking longer improves its reward. This was a genuine scientific finding: the SFT-on-CoT bootstrap step is not strictly necessary.

R1-Zero's weaknesses: endless repetition, poor readability, language mixing (switching between Chinese and English mid-response).

## R1: Four-Stage Pipeline

R1 addresses R1-Zero's readability problems:

1. **Cold-start SFT** — small set of high-quality reasoning examples to establish formatting and language consistency
2. **RL training (stage 1)** — GRPO on verifiable tasks (math, code) to discover strong reasoning patterns
3. **Rejection sampling SFT** — R1 generates many completions; high-quality trajectories filtered for another SFT round
4. **Second RL round** — final pass to align with human preferences (helpfulness, harmlessness)

## Performance vs. OpenAI o1-1217

| Benchmark            | o1-1217  | DeepSeek-R1 |
| -------------------- | -------- | ----------- |
| AIME 2024 pass@1     | 79.2     | **79.8**    |
| MATH-500 pass@1      | 96.4     | **97.3**    |
| LiveCodeBench pass@1 | 63.4     | **65.9**    |
| Codeforces Rating    | **2061** | 2029        |
| MMLU pass@1          | **91.8** | 90.8        |

Broadly a draw — R1 wins on math and most coding, o1 edges ahead on competitive programming and MMLU.

## Distilled Models

DeepSeek used rejection sampling on R1 to generate ~800K reasoning traces, then fine-tuned smaller dense models. This proved **more effective than running RL directly on small models** — smaller models lack the exploration capacity for RL. (Anthropic alleged DeepSeek also used Claude's outputs to augment this pipeline — see [[Detecting and preventing distillation attacks|distillation attack analysis]].)

| Model                | Base              | AIME 2024 pass@1                  |
| -------------------- | ----------------- | --------------------------------- |
| R1-Distill-Qwen-1.5B | Qwen2.5-Math-1.5B | 28.9%                             |
| R1-Distill-Qwen-7B   | Qwen2.5-Math-7B   | 55.5%                             |
| R1-Distill-Llama-8B  | Llama-3.1-8B      | 50.4%                             |
| R1-Distill-Qwen-14B  | Qwen2.5-14B       | 69.7%                             |
| R1-Distill-Qwen-32B  | Qwen2.5-32B       | **72.6%** (beats o1-mini's 63.6%) |
| R1-Distill-Llama-70B | Llama-3.3-70B     | 70.0%                             |

> [!info] The 32B result
> ==A dense 32B model outperforming o1-mini across AIME, MATH-500, GPQA Diamond, and LiveCodeBench== — runs on a single high-end workstation GPU. This is what made distilled reasoning models practical for consumer hardware.

## Why R1 Mattered

1. **First open-weight reasoning model at frontier quality** — prior to R1, o1-class models were all proprietary
2. **RL alone can produce reasoning** — R1-Zero was a scientific finding, not just engineering
3. **Distillation democratizes reasoning** — strong reasoning on consumer hardware
4. **MIT license** — full weights available for commercial use and further distillation
5. **Cost** — API pricing at launch ~\$0.55/M input tokens, roughly 20-30x cheaper than o1
