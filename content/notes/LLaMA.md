---
title: "LLaMA"
date: 2023-07-25
---
## LLaMa

From https://github.com/ggerganov/llama.cpp/issues/33#issuecomment-1465108022

> The [LLaMA model](https://arxiv.org/pdf/2302.13971.pdf) has a very similar architecture to GPT-J. It uses the same positional encoding ([RoPE](https://arxiv.org/pdf/2104.09864.pdf)), similar activation function (SiLU instead of GELU). The main differences are:
> - no bias tensors
> - some new normalization layers
> - extra tensor in the feed-forward part
> - a slightly different order of the operations
> - seems context size is not fixed? (if I understand correctly the code)

## LLaMA 2

With [llama.cpp](notes/llama.cpp.md)

---

With [ollama](https://github.com/jmorganca/ollama):
```sh
ollama run llama2
```

---

With llm and replicate https://simonwillison.net/2023/Jul/18/accessing-llama-2/

```sh
llm replicate add \
  replicate/llama70b-v2-chat \
  --chat --alias llama70b

llm -m llama70b "Invent an absurd ice cream sundae"
```

> [!note] This is based on a replicate-hosted API https://replicate.com/replicate/llama70b-v2-chat. 

From https://news.ycombinator.com/item?id=36783709 it seems pricey:
> [!quote] 
> As for pricing, that model's pages says: "Predictions run on Nvidia A100 (80GB) GPU hardware. Predictions typically complete within 17 seconds."
> And the pricing page (https://replicate.com/pricing) says Nvidia A100 (80GB) GPU hardware costs \$0.0032 per second.
> So Llama 2 70B would "typically" cost under 17 x 0.0032 = \$0.0544 per run.



