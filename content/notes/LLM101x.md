---
title: "Large Language Models: Application through Production"
date: 2023-06-13
tags:
- Course
aliases:
- Large Language Models Application through Production
---

I signed up [Large Language Models: Application through Production](https://learning.edx.org/course/course-v1:Databricks+LLM101x+2T2023/home) by Databricks on edX to learn more about applications of [Large Language Model](notes/LLM.md). This page contains my notes on the course.

![Slides](assets/Databricks-LLM101x.pdf)

## Introduction

This module goes through some key concepts and terminology.
- Language models: probabilistic models that assign probabilities to word sequences.
- Large: from 10~50M to many billions of parameters. Made possible by transformer architecture since ~2017.

Primitives:
- Token: basic building block of language models. Words, sub-words, characters, etc.
- Sentence: sequence of tokens.
- Vocabulary: complete list of tokens.

Tokenization:
1. Words:
   1. Intuitive
   2. Big vocabulary
   3. Complications such as misspelling, out-of-vocabulary (OOV) words, etc.
2. Characters:
   1. Small vocabulary
   2. No OOV
   3. Long sequences
   4. No word-level semantics
3. Sub-words:
  1. popular: byte pair encoding (BPE)

Word embeddings:
1. By frequency → sparsity issue
2. word/token → embedding function → word embedding/vector

## Application

This module is mostly an introduction to the transformer library from Hugging Face. The code examples are very straightforward to understand if you already know Python.
In fact, the whole lab takes around 10 minutes to complete if it's not waiting to download all the data sets and models along the way.

On the high level, a HF pipeline could have these steps:
`input --> id[prompt constructions] --> id[tokenizer (encoding)] --> model --> id[tokenizer (decoding)] --> output`

Some parameters to tweak:
- tokenizer:
	- `max_length`: max length of input sequence
- model:
	- `do_sample`: whether to use sampling
	  - `top_k`: top k tokens to sample from
	  - `top_p`: cumulative probability of top tokens to sample from
	  - `termperture`: temperature of sampling
	- `num_beams`: number of beams for beam search
	- `max_length`: max length of output sequence
	- `min_length`: min length of output sequence

## Embedding and Vector Store

### How do LMs learn knowledge
- fine-tuning
	- via model weights
	- _usually_ better suited to teach a model the specialized tasks
		- Studying for an exam 2 weeks away
- in-context learning
	- through model inputs
	- passing context as model inputs improves factual recall
		- "Take an exam with open notes"
	- downsides
		- Context length limitation
		- Longer context = higher API costs = longer processing times

We can turn words/images/audio with vectors
- similarity search
	- de-dup
	- semantic search
- recommendation
- finding security threats

![search and retrieval-augmented generation](assets/rag-workflow.png)

### How does Vector Search work

Vector search
- K-nearest neighbors (KNN): exact search; brute-force method
- ==Approximate nearest neighbors (ANN)==: 
	- trade accuracy for speed. 
	- Common indexing algorithms that output a ==vector index==
		- Proximity graphs: HNSW
			- Build proximity graphs based on L2 distance
		- Clustering: FAISS
			- forms clusters of dense vectors and conducts product quantization
			- Not good with sparse vectors

#### How to measure similarity
- Distance metrics: L2 (Euclidean)
- Similarity metrics: Cosine

Note: used on normalized embeddings, they produce functionally equivalent ranking distances. 

Product quantization: to compress vectors with fewer bytes
1. Split the big vector into segments of sub-vectors
2. Each sub-vector is quantized independently, and mapped to the nearest centroid

### Filtering

1. Post-query
2. In-query
3. Pre-query

### Vector Stores

When do you need it? When you need ==context augmentation==.

Vector databases
- CRUD
- Optimized for unstructured data (vectors)
- Built-in AAN algorithms

Vector libraries: 
- create vector indices
- sufficient for small, static data
- stored in-memory

Tips:
1. Choose your embedding model wisely
	1. It should represent **BOTH** queries and documents.
2. Ensure the ==embedding space== is the same for both queries and documents. 
	1. Use the same model for indexing and querying
	2. If use different models, make sure they are trained on similar data 🤔
3. Chunking strategy
	1. Considerations
		1. How relevant
		2. Token limit
		3. User behavior
			1. How long are the queries?
			2. Try to match with the context 
   
## Multi-stage Reasoning


## Miscellaneous

Databricks' notebooks turn out to be Python files with some special comments (e.g. `COMMAND`, `MAGIC`); therefore the output is not included.  