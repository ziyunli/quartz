---
created: 2026-03-14
---

> [!info] AI-assisted annotations
> HN thread analysis and synthesis with Claude Opus 4.6 via Claude Code.

## HN: Real-world local LLM setups (Oct 2025)

Source: [Ask HN: Who uses open LLMs and coding assistants locally?](https://news.ycombinator.com/item?id=45771870)

### GPT-OSS-120b: runtime and quantization matter

The biggest finding: GPT-OSS-120b quality varies wildly depending on how you run it. Runtime ranking per [embedding-shape](https://news.ycombinator.com/item?id=45781029):

1. **TensorRT** — fastest
2. **llama.cpp** — easy + fast (~260 tok/s on RTX Pro 6000 for 20b variant)
3. **vLLM** — best for batching/throughput, harder to deploy
4. **Ollama** — easiest, slowest

Critical: use **native MXFP4 weights**, not Q8 quantization. [gunalx](https://news.ycombinator.com/item?id=45800456) was getting worse results from 120b than 20b — turned out Q8 degrades quality drastically. Early runners (Ollama, vLLM) also [botched implementations at launch](https://news.ycombinator.com/item?id=45774966), so many people wrote the model off prematurely.

MoE architecture is the key enabler: 120B total params but only a fraction activate per token, so it runs on hardware that couldn't touch a dense 120B model. Same for Qwen3-Coder-30B-A3B (30B params, 3B active).

### The agentic coding gap

[simonw](https://news.ycombinator.com/item?id=45773803) couldn't find a local model on 64GB Mac or 128GB that reliably runs bash-in-a-loop over multiple turns — the core of agentic coding (Claude Code, Codex CLI).

[embedding-shape's solution](https://news.ycombinator.com/item?id=45773874) with GPT-OSS-120b + Codex + llama.cpp:

- Hard-code inference params: `top_k=0`, `top_p=1.0`, `temperature=1.0` (Codex doesn't expose these)
- Get Harmony parsing working correctly in llama.cpp
- Heavy `AGENTS.md` prompting to teach the agent workflow

Implication: frontier models like GPT-5 are trained with tool-use loops in mind; open models need that behavior bolted on via prompting and inference config.

### Practical sweet spot: Qwen3-Coder on a 64GB Mac

[dust42](https://news.ycombinator.com/item?id=45773793) runs Qwen3-Coder-30B-A3B Q4 via llama.cpp on MBP 64GB — 50 tok/s generation, 550 tok/s prompt processing. Uses continue.dev for chat and llama.cpp's VSCode plugin for FIM completion.

**KV caching trick**: load files with "read the code and wait" while you type your real instructions. KV caching makes the response near-instant once you submit — effectively hiding prompt processing latency behind typing time.

Honest assessment: "When giving well-defined small tasks, it is as good as any frontier model." For anything harder → Claude or DeepSeek via API.

Recommended resources for quants:

- [Unsloth GGUFs](https://huggingface.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF) — Q4_K_M variant
- [llama.cpp Apple Silicon benchmarks](https://github.com/ggml-org/llama.cpp/discussions/4167)
- [Quant selection guide](https://gist.github.com/Artefact2/b5f810600771265fc1e39442288e8ec9)

### Hardware setup census

| Hardware                              | Model                    | Runtime         | tok/s      | User                                                             |
| ------------------------------------- | ------------------------ | --------------- | ---------- | ---------------------------------------------------------------- |
| Ryzen 9 + RTX Pro 6000 96GB           | GPT-OSS-120b             | llama.cpp       | ~260 (20b) | [embedding-shape](https://news.ycombinator.com/item?id=45773654) |
| M4 Max 128GB                          | GPT-OSS-120b MLX 8bit    | MLX             | 66         | [jetsnoc](https://news.ycombinator.com/item?id=45775449)         |
| M4 Max 128GB                          | Qwen3-Coder-30B-A3B 8bit | MLX             | 78         | [jetsnoc](https://news.ycombinator.com/item?id=45775449)         |
| MBP 64GB                              | Qwen3-Coder-30B-A3B Q4   | llama.cpp       | 50         | [dust42](https://news.ycombinator.com/item?id=45773793)          |
| Dual RTX 3090                         | Qwen3-Coder-30B-A3B Q8   | llama.cpp       | 100        | [Mostlygeek](https://news.ycombinator.com/item?id=45777958)      |
| HP ZBook Ultra G1A 128GB (Strix Halo) | GPT-OSS-20b              | llama.cpp       | —          | [hacker_homie](https://news.ycombinator.com/item?id=45773885)    |
| Mac Studio M4 Max 128GB               | GPT-OSS-120b             | Ollama          | —          | [Greenpants](https://news.ycombinator.com/item?id=45779881)      |
| Framework Desktop 128GB               | GPT-OSS-120b             | lemonade-server | —          | [dennemark](https://news.ycombinator.com/item?id=45777371)       |

Common pattern: **Mac unified memory for ease, NVIDIA for raw speed, AMD Strix Halo as budget middle ground.** Memory bandwidth matters more than raw RAM — Max/Ultra chips outperform Pro chips at the same RAM capacity.

## HN: Qwen3.5 and the state of local models (Feb 2026)

Source: [Qwen3.5 122B and 35B models offer Sonnet 4.5 performance on local computers](https://news.ycombinator.com/item?id=47199781)

### StepFun-3.5-Flash: the dark horse open model

`kir-gadjello` ([thread](https://news.ycombinator.com/item?id=47202548)) uses StepFun-3.5-Flash (196B/11B active MoE) for a complex Rust codebase with hundreds of integration tests and nontrivial concurrency. Claims it covers 95% of coding needs, beats MiniMax M2.5, and is competitive with GLM-5 ([comparison](https://news.ycombinator.com/item?id=47222693)).

Key insights:

- "With suitable task decomposition or a test harness you can make the model do what you thought it could not" ([thread](https://news.ycombinator.com/item?id=47204461))
- 2x faster than competitors — fast iteration loops are a real productivity advantage ([nodakai](https://news.ycombinator.com/item?id=47204179))
- Accuses MiniMax of heavy distillation from western frontier models, while StepFun has extensive custom post-training R&D
- "The optimal configuration for maximizing output of correct software features per dollar involves using StepFun or its future class competitor for bulk coding" ([thread](https://news.ycombinator.com/item?id=47223198))

Resource: [StepFun-3.5-Flash on GitHub](https://github.com/stepfun-ai/Step-3.5-Flash)

### Qwen3.5 model selection: 27B dense vs 35B MoE vs 122B MoE

The 35B-A3B MoE has only 3B active params — roughly equivalent to an 11B dense model per `regularfry` ([thread](https://news.ycombinator.com/item?id=47207660)). Multiple commenters say the **27B dense is the best in the lineup for quality:size** ([smahs](https://news.ycombinator.com/item?id=47206619), [CamperBob2](https://news.ycombinator.com/item?id=47201915)). The 122B-A10B is the only one people describe as "Sonnet-esque":

- `pram` ([thread](https://news.ycombinator.com/item?id=47204963)) runs it on M4 Max 128GB via LM Studio + OpenCode
- `derekp7` ([thread](https://news.ycombinator.com/item?id=47201477)) says it's the first local model to nail an RPN calculator one-shot at q3 dynamic quant

**Recommendation by hardware:**

- NVIDIA 4090 (24GB): 27B dense or 35B-A3B MoE
- Mac 128GB: 122B-A10B MoE (MLX quants preferred)
- 32GB machines: 35B-A3B is the ceiling

### Quantization sweet spot: 4-bit

`jackcosgrove` ([thread](https://news.ycombinator.com/item?id=47202822)) ran an analysis: 4-bit quantization is 99% similar to float32 at half the size of 8-bit — the clear sweet spot. `deepsquirrelnet` ([thread](https://news.ycombinator.com/item?id=47202953)) confirms GPT-OSS models were trained natively in MXFP4 (4-bit floating point, e2m1 format with per-block 8-bit scaling exponents).

Recommendations from `zargon` ([thread](https://news.ycombinator.com/item?id=47202957)):

- For coding: don't go below Q4_K_M
- Prefer **unsloth XL** or **ik_llama IQ** quants at Q4 — better quality at same size
- Ideally Q5 or Q6 if you have the VRAM

Resources:

- [Unsloth GGUF benchmarks for Qwen3.5](https://unsloth.ai/docs/models/qwen3.5/gguf-benchmarks)
- [MXFP4 spec (OCP Microscaling Formats)](https://www.opencompute.org/documents/ocp-microscaling-formats-mx-v1-0-spec-final-pdf)
- [CMU Modern AI course](https://modernaicourse.org/) — covers quantization fundamentals
