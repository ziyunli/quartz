---
title: Large Language Model
---
## Before LLM

> Until 2017, most NMT models, including the one that powered Google Translate, were [recurrent neural networks](https://en.wikipedia.org/wiki/Recurrent_neural_network). RNNs use [Long Short-Term Memory](https://en.wikipedia.org/wiki/Long_short-term_memory) (LSTM) cells to factor word order into their calculations.[^2]

> In 2017, a landmark paper titled “[Attention Is All You Need](https://arxiv.org/abs/1706.03762)” changed the way data scientists approach NMT and other NLP tasks. That paper proposed a better way to process language based on _transformer models_ that eschew LSTMs and use [neural attention](https://en.wikipedia.org/wiki/Attention_(machine_learning)) mechanisms to model the context in which words are used.

![language-model](images/language-model.png)

![language-model-2](images/language-model-2.png)

![language-model-3](images/language-model-3.png)
## BERT (Bidirectional Encoder Representations from Transformers)

> BERT isn’t generally useful by itself, but it can be fine-tuned to perform specific tasks such as sentiment analysis or question answering. Fine-tuning is accomplished by further training the pre-trained model with task-specific samples at a reduced learning rate, and it is _much_ less expensive and time-consuming than training BERT from scratch.

![bert](images/bert.png)

> Aside from the fact that it was trained with a huge volume of text, the key to BERT’s ability to understand human language is an innovation known as [Masked Language Modeling](https://analyticsindiamag.com/a-complete-tutorial-on-masked-language-modelling-using-bert/). MLM turns a large corpus of text into a training ground for learning the structure of a language. When BERT models are pretrained, a specified percentage of the words in each batch of text – usually 15% – are randomly removed or “masked” so the model can learn to predict the missing words from the words around them. Unidirectional models look at the text to the left or the text to the right and attempt to predict what the missing word should be. MLM uses text on the left _and_ right to inform its decisions.

## GPT (Generative Pretrained Transformer)

> Unlike BERT, GPT models can perform certain NLP tasks such as text translation and question-answering _without fine-tuning_, a feat known as _zero-shot_ or _few-shot learning_.
> ...
> ChatGPT is a fine-tuned version of GPT-3.5, which itself is a fined-tuned version of GPT-3. At its heart, ChatGPT is a transformer encoder-decoder that responds to prompts by iteratively predicting the first word in the response, then the second word, and so on.

> The entire body of knowledge present on the Internet in September 2021 (and then some) was baked into those 175 billion parameters during training. It’s akin to you answering a question off the top of your head rather than reaching for your phone and Googling for an answer. When Microsoft incorporated GPT-4 into Bing, they added a separate layer providing Internet access.

## [llama.cpp](https://github.com/ggerganov/llama.cpp)

> The [LLaMA model](https://arxiv.org/pdf/2302.13971.pdf) has a very similar architecture to GPT-J. It uses the same positional encoding ([RoPE](https://arxiv.org/pdf/2104.09864.pdf)), similar activation function (SiLU instead of GELU). The main differences are:
> - no bias tensors
> - some new normalization layers
> - extra tensor in the feed-forward part
> - a slightly different order of the operations
> - seems context size is not fixed? (if I understand correctly the code)[^1]

## Applications

### LangChain

> ...it makes it easy to call OpenAI’s GPT, say, a dozen times in a loop to answer a single question, and mix in queries to Wikipedia and other databases.
> The clever bit is that, using LangChain, you _intercept_ GPT when it starts a line with _“Act:”_ and then you go and do that action for it, feeding the results back in as an _“Observation”_ line so that it can “think” what to do next.[^3]

## [Prompt Injection](notes/Prompt%20Injection.md)

## Fine-Tuning

How to generate training data https://news.ycombinator.com/item?id=36070533
1. make your own RLHF dataset - like OpenAI and Open Assistant
2. exfiltrate data from a bigger/better LLM - Vicuna & family
3. use your pre-trained LLM to generate RLAIF data, no leeching - ConstitutionalAI, based on a set of rules instead of labelling examples

How to use it with vector store https://news.ycombinator.com/item?id=36070797
> I would strongly recommend against fine-tuning over a set of documents as this is a very lossy information system retrieval system. LLMs are not well suited for information retrieval like databases and search engines.
> 
> The applications of fine-tuning that we are seeing have a lot of success is making completion models like LLaMA or original GPT3 become prompt-able. In essence, prompt-tuning or instruction-tuning. That is, giving it the ability to respond with a user prompt, llm output chat interface.
> 
> Vector databases, for now, are a great way to store mappings of embeddings of documents with the documents themselves for relevant-document information retrieval.

Using vector store with fine-tuning https://news.ycombinator.com/item?id=36079880

> I want the user to be able to ask technical questions about a set of documents, then the user should retrieve a summary-answer from those documents along with a source.
> 
> I first need to finetune GPT4 so it better understands the niche-specific technical questions, the words used, etc. I could ask the finetuned model questions, but it won't really know from where it got the information. Without finetuning the summarised answer will suffer, or it will pull out the wrong papers.
> 
> Then I need to use a vector database to store the technical papers for the model to access; now I can ask questions, get a decent answer, and will have access to the sources.



[^1]: https://github.com/ggerganov/llama.cpp/issues/33#issuecomment-1465108022
[^2]: https://www.atmosera.com/ai/understanding-chatgpt/ "Understanding ChatGPT"
[^3]: https://interconnected.org/home/2023/03/16/singularity "The surprising ease and effectiveness of AI in a loop"