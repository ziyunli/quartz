---
title: LLM Sampling Parameters
tags:
  - LLM
created: 2026-03-14
draft: true
---

> [!info] AI-assisted annotations
> Synthesized from [llama.cpp guide](https://blog.steelph0enix.dev/posts/llama-cpp-guide/) (2024-10-27) with additional context and paper references. Claude Opus 4.6 via Claude Code.

LLM text generation works by producing a probability distribution over all tokens in the vocabulary, then using **samplers** to select the next token. Samplers are applied in a chain — order matters. llama.cpp's default chain: logits → logit-bias → penalties → DRY → top-k → typical → top-p → min-p → XTC → temperature → dist.

## Core Samplers

### Temperature

Controls randomness by scaling logits before the softmax. Higher = more random, lower = more deterministic. Keep in 0.2–2.0 range. Setting to 0 is greedy decoding (always picks the most probable token).

**Dynamic temperature** adjusts per-token based on entropy: low-entropy (confident) predictions get lower temperature, high-entropy get higher. This encourages creativity without hallucination at higher base temperatures. See [dynatemp explanation](https://rentry.org/dynamic_temperature) and [author's Reddit post](https://www.reddit.com/r/Oobabooga/comments/191klr8/some_information_about_dynamic_temperature_added/).

Parameters: base temperature, dynatemp range (added/subtracted), dynatemp exponent (controls the curve shape).

### Top-K

Keep only the K most probable tokens, discard the rest. Higher K = more diversity. Simple and fast but the fixed cutoff ignores the actual probability distribution shape.

### Top-P (Nucleus Sampling)

Keep the smallest set of tokens whose cumulative probability exceeds P. Adapts to the distribution: when the model is confident (one token dominates), fewer tokens pass; when uncertain, more pass. Typically set to 0.9–0.95.[^nucleus]

### Min-P

Keep tokens whose probability is at least P × (probability of the most likely token). Unlike top-p, this is relative to the peak — it naturally adapts to both confident and uncertain distributions without the accumulation artifacts of top-p.[^minp]

### Locally Typical Sampling (Typical-P)

Keeps tokens whose log-probability is close to the expected information content (entropy) of the distribution. The intuition: "typical" tokens are neither boringly predictable nor surprisingly rare. Set via the `typical_p` parameter.[^typical]

## Anti-Repetition Samplers

### Repetition Penalty

Reduces probability of tokens already present in the last N tokens. Works by dividing logits by a penalty factor, then applying frequency and presence penalties:

- **Repeat penalty** — divides logit by this factor (1.0 = disabled)
- **Frequency penalty** — penalty proportional to how many times the token appeared
- **Presence penalty** — flat penalty if the token appeared at all
- **Repeat last N** — how far back to look

### DRY (Don't Repeat Yourself)

Detects repeating token _sequences_ (not just individual tokens) and penalizes tokens that would extend a repetition. Penalty: `multiplier × base ^ (n - allowed_length)` where n is the matching sequence length. More targeted than repetition penalty — it catches structural repetition (repeated sentences/paragraphs) rather than just repeated words.[^dry]

Parameters: multiplier, base, allowed length, penalty last N, sequence breakers (default: newline, colon, quote, asterisk).

## Alternative Samplers

### XTC (Exclude Top Choices)

Inverts the usual approach: instead of pruning unlikely tokens, it _removes the most likely tokens_ with a configurable probability. This forces the model to use less obvious word choices, reducing repetitive phrasing. Applied probabilistically — XTC probability controls how often it kicks in, XTC threshold sets the cutoff.[^xtc]

### Mirostat

An entropy-targeting sampler that **replaces top-k, top-p, and typical-p**. It dynamically adjusts the number of candidate tokens to maintain a target perplexity (entropy), avoiding both the repetitiveness of low-perplexity generation and the incoherence of high-perplexity generation.[^mirostat]

Parameters:

- **Version** — 0 = disabled, 1 = Mirostat, 2 = Mirostat 2.0
- **Learning rate (eta)** — convergence speed toward target entropy
- **Target entropy (tau)** — desired perplexity level

## Practical Guidance

- For **deterministic/factual tasks** (coding, structured output): low temperature (0.1–0.4), min-p around 0.05–0.1
- For **creative tasks** (writing, brainstorming): higher temperature (0.7–1.2), consider dynamic temperature
- For **coding with local models**: Codex-style agents hard-code `top_k=0, top_p=1.0, temperature=1.0` and rely on the model's training rather than sampler shaping (see [[Running Local LLM#The agentic coding gap]])
- DRY is generally more useful than repetition penalty for preventing structural repetition
- When using Mirostat, disable top-k/top-p/typical — they conflict
- "Your settings are (probably) hurting your model" — [r/LocalLLaMA analysis](https://www.reddit.com/r/LocalLLaMA/comments/17vonjo/your_settings_are_probably_hurting_your_model_why/) argues most people over-tune samplers; conservative defaults often work best

## References

[^nucleus]: Holtzman et al. (2019), [The Curious Case of Neural Text Degeneration (arXiv:1904.09751)](https://arxiv.org/abs/1904.09751) — introduces nucleus (top-p) sampling.

[^minp]: Nguyen et al. (2024), [Turning Up the Heat: Min-p Sampling for Creative and Coherent LLM Outputs (arXiv:2407.01082)](https://arxiv.org/abs/2407.01082).

[^typical]: Meister et al. (2022), [Locally Typical Sampling (arXiv:2202.00666)](https://arxiv.org/abs/2202.00666).

[^dry]: [DRY sampler PR — text-generation-webui](https://github.com/oobabooga/text-generation-webui/pull/5677).

[^xtc]: [XTC sampler — r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/comments/1ev8n2s/exclude_top_choices_xtc_a_sampler_that_boosts/) and [implementation PR](https://github.com/oobabooga/text-generation-webui/pull/6335).

[^mirostat]: Basu et al. (2020), [Mirostat: A Neural Text Decoding Algorithm (OpenReview)](https://openreview.net/pdf?id=W1G1JZEIy5_).
