## Week 1: What is an Agent? + A Brief History of Language Modeling

### The Evolution of Language Models

#### The Rule-Based Era (1950s–1990s)

- Early approach: treat language as logical puzzles — map every grammatical rule to "solve" language
- **The Turing Test (1950)**: Alan Turing proposed that if a machine could mimic human conversation perfectly, it could be considered "thinking"

> [!question] Does any AI pass the Turing Test?
> By any reasonable interpretation of Turing's original criteria (fool 30% of judges in 5-minute conversations), frontier models in 2025–2026 **pass trivially** in casual conversation. A UC San Diego study found GPT-4 fooled ~50% of judges. But this reveals the **limitation of the test**, not the capability of LLMs — it measures surface-level conversational mimicry. Models can pass while still hallucinating, failing at spatial reasoning, and having no persistent memory. The Turing Test was designed when producing fluent text seemed impossibly hard. Turns out fluency was the _easy_ part — reasoning, grounding, and agency are the hard problems. The field has moved from "can you talk like a human?" to "can you _work_ like one?"

- **Chomskyan Linguistics**: Noam Chomsky argued for "Universal Grammar" — an innate, rule-based biological structure for language. Computers tried to mimic this with **Context-Free Grammars (CFGs)**

> [!example] CFG Example
>
> ```
> S  → NP VP
> NP → Det N
> VP → V NP
> Det → "the" | "a"
> N  → "cat" | "dog" | "fish"
> V  → "chased" | "ate"
> ```
>
> This generates sentences like "the cat chased a dog." A CFG can parse the _structure_ of "I love dates" perfectly (`S → NP VP → "I" V NP`) but has **zero ability** to tell you whether "dates" means fruit or romance. The grammar is correct; the meaning is lost. This is the core motivation for the statistical shift — ==you need _context from data_, not just structural rules==.

- **Activity — Word Sense Disambiguation (WSD)**: Write strict logic-only rules to disambiguate "date" (dried fruit / romantic meeting / calendar day), then try to break another group's rules. Demonstrates the brittleness of rule-based approaches

> [!example] WSD: Why rules break
> Suppose you write these rules:
>
> - IF "love" is in the sentence → romantic meeting
> - IF "january" is in the sentence → calendar day
> - IF "smoothie" is in the sentence → dried fruit
>
> They seem reasonable, but adversarial examples break every one:
>
> - "I love to put dates in my smoothie" → rule says _romantic_ (matches "love"), actually **dried fruit**
> - "I have a Hinge date planned in January" → rule says _calendar day_ (matches "January"), actually **romantic meeting**
> - "The date smoothie expires is on the label" → rule says _dried fruit_ (matches "smoothie"), actually **calendar day**
>
> No matter how many rules you add, natural language is ambiguous enough that you can always construct a counterexample. This is the fundamental argument for the statistical shift — you need _distributional context_, not brittle pattern matching.

#### The Statistical Shift & Word Embeddings (1990s–2013)

- Insight: "The world is too messy for rules." Instead, use large corpora (Wall Street Journal, Wikipedia, etc.) to calculate **probability of word sequences**
- **N-Grams**: Predict the nth word from the previous n−1 words. Fundamentally a **Markov Chain** — future state depends only on the current state, not the entire history

> [!info] What's a Markov Chain?
> A system where the probability of the next state depends _only_ on the current state, not on any prior history (**memorylessness**).
>
> - **Bigram** (N=2): P(next word | just the previous word). "The cat sat on the \_\_\_" → only looks at "the" to predict next
> - **Trigram** (N=3): P(next word | previous 2 words) → only looks at "on the"
>
> N-grams were a huge leap from rules — just _count word sequences_ in a corpus. But the Markov property is also their fatal flaw. In "The doctor who saved the patient's life was a \_\_\_", a bigram only sees "a" and has no idea about "doctor" from 10 words ago. This ==limited memory== is exactly the problem RNNs tried to solve with hidden states, LSTMs improved with cell states, and Transformers finally cracked with self-attention — where every word attends to every other word regardless of distance.
>
> Put simply, "current state" = a **fixed sliding window** of N−1 words, and N is much smaller than the total history. The Markov assumption isn't a belief that only recent words matter — it's a **practical compromise** (a vocabulary of 50k words with N=5 means up to $50000^4$ possible contexts). The entire arc of progress is expanding that window:
>
> - **N-grams**: ~2–5 tokens (explicit, fixed)
> - **RNNs**: theoretically unlimited, ~10–20 in practice (vanishing gradient)
> - **LSTMs**: ~100–200 tokens (cell state helps, but still degrades)
> - **Transformers**: full context window, 2k–128k+ tokens (self-attention)

#### The Vector Revolution (2013)

- **Word2Vec** and **GloVe**: Represent words as points in a 300-dimensional space instead of unique IDs
- Key insight: _"You shall know a word by the company it keeps."_ Words with similar meanings (e.g., "King" and "Queen") are mathematically closer together

#### Recurrent Neural Networks (RNNs)

- Process tokens sequentially, maintaining a **hidden state**
- Problem: **Vanishing Gradient** — as input grows, the influence of early words on later words decays to zero

#### LSTMs (Long Short-Term Memory)

- Introduced **gates** (Input, Forget, Output) and a **cell state** acting as a persistent memory conveyor belt
- Solved the vanishing gradient problem
- New problem: still **sequential** — cannot parallelize training; must process word-by-word in order

#### The Transformer & Scaling Laws (2017–Present)

- **"Attention is All You Need"** (2017): Removed the sequence requirement entirely
- **Self-Attention**: Every word looks at every other word simultaneously, enabling the model to understand **global context** instantly
- **Scaling Laws**: As parameters and data increase, loss decreases in a predictable **power law**, driving the race for trillion-parameter models

### Defining the AI Agent

#### From Completion to Agency

- **Passive LLM**: Prompt in → completion out. No memory of the world, no way to change it
- **Active Agent**: Autonomous, Reactive, and Proactive. Can observe results, realize mistakes, and try different approaches

#### The Cognitive Architecture of an Agent

1. **Planning**
   - _Task Decomposition_: Break a "Goal" into "Steps"
   - _Self-Reflection_: Evaluate own output — "Does this make sense?" (e.g., Self-Refine, Reflexion frameworks)
   - _Chain of Thought (CoT)_: Force the model to "show its work" step-by-step, reducing logic errors

2. **Memory**
   - _Short-term_: Conversation history in the context window
   - _Long-term_: Vector databases via RAG or other retrieval mechanisms — the agent can search past experiences or external documents

3. **Tool Use / Action**
   - _Function Calling_: The model outputs executable code, not just text
   - _MRKL (Miracle) Architecture_: Modular Reasoning, Knowledge, and Language — combines an LLM with "expert" tools (calculator, weather API, etc.)

4. **Perception**
   - Modern agents are often **multimodal** — they can "see" screenshots, "hear" voice commands, not just read text
   - Inputs from different modalities are processed together for richer task understanding

#### The ReAct Pattern (Reasoning + Acting)

The most common agentic loop. Example — "How many women are there in Paris?":

1. **Thought**: "I need to find the population of Paris and divide by 2."
2. **Action**: `Search("Population of Paris")`
3. **Observation**: "The search result says 2.1 million."
4. **Thought**: "Now I need to use the calculator tool."
5. **Action**: `Calculate(2100000 / 2)`
