---
title: "llama.cpp"
date: 2023-07-18
---

[llama.cpp](https://github.com/ggerganov/llama.cpp)

> The [LLaMA model](https://arxiv.org/pdf/2302.13971.pdf) has a very similar architecture to GPT-J. It uses the same positional encoding ([RoPE](https://arxiv.org/pdf/2104.09864.pdf)), similar activation function (SiLU instead of GELU). The main differences are:
> - no bias tensors
> - some new normalization layers
> - extra tensor in the feed-forward part
> - a slightly different order of the operations
> - seems context size is not fixed? (if I understand correctly the code)[^1]

[^1]: https://github.com/ggerganov/llama.cpp/issues/33#issuecomment-1465108022