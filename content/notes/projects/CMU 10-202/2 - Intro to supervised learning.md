---
tags:
  - Courses
---

Video: [Lecture 2: Intro to supervised machine learning - YouTube](https://youtu.be/xIQkf7ZGQhM)

## The supervised machine learning paradigm

- The "usual" programming approach:

  ```mermaid
  flowchart TD
  	A[**Specification** of the desired behavior]
  	B[Think about logic that will achieve that behavior]
  	C[Write program]

  	A --> B --> C
  ```

- The ML approach

  ```mermaid
  flowchart TD
    A[**Examples** of the desired behavior]
    B[ML Algorithm]
    C[Produced program]

    A --> B --> C
  ```

> [!info] When is ML better than traditional programming?
> Traditional programming works well when you have a ==complete specification== of desired behavior (e.g., sorting a list — you know exactly what every input should map to). ML shines when it's ==easier to specify examples of desired behavior than the behavior itself== — e.g., image classification or answering arbitrary questions via a chatbot. It's saying _what_ you want instead of _how_ to do it.

## Notation

- "Input" - the input that we will provide to the ML produced program
- "Desired outputs" - the output we want our ML program to produce for some corresponding input
- "Training set" - a collection of inputs and their corresponding desired outputs

> [!example] Two examples of supervised learning tasks
>
> - **Image classification**: input = image of a cat or dog, desired output = label ("cat" or "dog"). Labels come from ==human annotation==.
> - **Language modeling**: input = start of a sentence (e.g., "the quick brown"), desired output = next word ("fox"). Training data is constructed ==automatically== from text — every prefix of a sentence becomes an input, and the next word becomes the desired output. Unlike image classification, there isn't necessarily one right answer; the goal is to model a ==distribution of possible next words==.

## The three ingredients of ML algorithm

1. Model (i.e. "ML program")
   - function that maps inputs to **predicted outputs**
   - h (hypothesis) Inputs -> Predicted outputs
   - Model class/architecture: family of models we consider

> [!info] Predicted outputs ≠ desired outputs
> The model doesn't just output a label like "cat". It outputs ==predicted outputs==, typically a list of probabilities — e.g., `[0.1, 0.9]` meaning 10% chance of dog, 90% chance of cat. This distinction matters because in tasks like language modeling, you want to model a probability distribution, not just predict a single word.

2. Loss function
   - function that measures the difference between predicted and desired outputs
     - L: predicted output x desired output -> R+
   - loss is "large" if prediction is bad and "small"/zero if prediction is good
3. Optimization procedure (training)
   - Find the model (or a model) within the model class that achieves low loss on the training set
     - low **sum** of loss over all predicted and desired outputs on the training set

> [!question] What is cross-entropy loss?
> Cross-entropy measures how well a predicted probability distribution matches the actual answer: ==**−Σ (true probability × log(predicted probability))**==
>
> - **Perfect prediction** `[0, 1]` when true = cat: loss = −log(1) = **0**
> - **Confident and wrong** `[0.99, 0.01]` when true = cat: loss = −log(0.01) = **4.6**
> - **Uncertain** `[0.5, 0.5]` when true = cat: loss = −log(0.5) = **0.69**
>
> It ==punishes confident wrong answers heavily== and rewards putting high probability on the correct answer. Unlike a simple 0/1 "right or wrong" loss, it gives the optimization a ==smooth gradient== — _how much_ more or less confident should you be? For language modeling, if the model predicts the next word with probability 0.8, the loss for that word is −log(0.8).

> [!info] In modern AI, the only thing that really varies is the model class
>
> - Loss function is (almost) always ==cross-entropy==
> - Optimization is (almost) always ==stochastic gradient descent==
> - What differs between ML algorithms is the ==model class/architecture== — e.g., linear models vs. neural networks of a given size
> - Reinforcement learning uses a slightly different loss function and optimization procedure, but that comes later in the course

## Generalization

- ML find a "good" model on the training set
- **Want**: model that performs well on **new** examples
- "Test set" - an additional set of examples (inputs and desired outputs) that we do **not** use to train (optimize) the model
- For "general" AI: test on "downstream" tasks

> [!warning] Why training set performance alone is meaningless
> You could achieve perfect training performance with a ==lookup table== — just store every input/output pair and look them up. That's not learning, it's memorization. The whole point of ML is performing well on _new_ examples from the same task.

> [!info] Downstream tasks in general AI
> For general-purpose AI, we don't just evaluate by loss on a holdout set. Nobody picks a chatbot based on its cross-entropy score. Instead, we evaluate on ==downstream tasks== — does it actually solve math problems, write code, answer questions well? A surprising and fortunate finding: ==lower training loss tends to correlate with better downstream task performance==, which is a big part of why large language models are so useful.
