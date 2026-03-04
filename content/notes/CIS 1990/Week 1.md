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

> [!question] Word2Vec vs GloVe vs modern embedding models vs vector DBs
> These are three different layers that often get conflated:
>
> **Word2Vec** (2013, Google) is **predictive** — trains a shallow neural network where, given a word, it predicts surrounding words (Skip-gram) or vice versa (CBOW). The hidden layer weights become the embeddings.
>
> **GloVe** (2014, Stanford) is **count-based** — builds a word-by-word co-occurrence matrix across the entire corpus, then factorizes it. "Global Vectors" uses global statistics rather than local windows.
>
> Both produce very similar quality **static embeddings** — ==one fixed vector per word, regardless of context==. "bank" (financial) and "bank" (riverbank) get the same vector. This is their shared fatal flaw.
>
> **Modern embedding models** (OpenAI's `text-embedding-3`, Cohere Embed, etc.) are transformer-based and produce **contextual embeddings**. They take an entire input string and return one vector for the whole thing. `embed("I deposited money at the bank")` and `embed("I sat by the river bank")` produce different vectors because internally, self-attention lets every token influence the final representation.
>
> **Vector databases** (Pinecone, Qdrant, Chroma, pgvector, etc.) are not embedding algorithms at all — they're ==storage and retrieval infrastructure== for fast similarity search over millions of vectors using approximate nearest neighbor (ANN) algorithms. They don't care what produced the vectors.
>
> The full RAG pipeline from the cognitive architecture section: embed documents → store in vector DB → at query time, embed the question, search the DB for similar vectors, retrieve matching documents → feed into the LLM's context window as "memory."

#### Recurrent Neural Networks (RNNs)

- Process tokens sequentially, maintaining a **hidden state**
- Problem: **Vanishing Gradient** — as input grows, the influence of early words on later words decays to zero

> [!question] What is the "hidden state"?
> A vector that acts as the network's **working memory** as it reads word by word. At each time step, the RNN takes two inputs — the current word's embedding and the previous hidden state — and produces a new hidden state:
>
> - `h_0 = [0, 0, ...]` (blank memory)
> - `h_1 = f(W · [h_0, embed("The")])` → encodes "The"
> - `h_2 = f(W · [h_1, embed("cat")])` → encodes "The cat"
> - `h_3 = f(W · [h_2, embed("sat")])` → encodes "The cat sat"
>
> `W` is a learned weight matrix reused at every step; `f` is a nonlinear activation (typically tanh). ==It's called "hidden" because you never directly observe it== — the input (words) and output (predictions) are visible, but the hidden state is an internal representation the network learns on its own.
>
> The problem: each hidden state is a **fixed-size vector** (e.g., 256 dimensions). At step 20, information from step 1 has been through 19 rounds of matrix multiplication and squashing through tanh. Each step **overwrites** the hidden state, compressing everything seen so far into the same fixed number of dimensions. Early information gets diluted — this is the vanishing gradient.

#### LSTMs (Long Short-Term Memory)

- Introduced **gates** (Input, Forget, Output) and a **cell state** acting as a persistent memory conveyor belt
- Solved the vanishing gradient problem
- New problem: still **sequential** — cannot parallelize training; must process word-by-word in order

> [!question] What does the forget gate do? What's a "conveyor belt"?
> The **forget gate** decides what to erase from the cell state at each time step. It looks at the current input and the previous hidden state, and outputs a value between 0 and 1 for each dimension: 0 = completely erase, 1 = keep entirely, 0.7 = retain 70%.
>
> For example, if the cell state has been tracking "the subject is plural" and the model hits a period starting a new sentence, the forget gate can learn to output ~0 for those dimensions — that information is now stale.
>
> The three gates work in sequence on the cell state:
>
> - `C_t = f_t ⊙ C_{t-1} + i_t ⊙ candidate_t`
>   - First term: **forget gate** erases (element-wise multiply by 0–1)
>   - Second term: **input gate** writes new information
> - `h_t = o_t ⊙ tanh(C_t)` — **output gate** reads from cell state into hidden state
>
> The **"conveyor belt"** is an analogy for the cell state's path through time. Items (information) ride the belt forward; at each station (time step), workers can remove items (forget gate), add items (input gate), or inspect items (output gate). ==The key property: the cell state flows via addition and element-wise multiplication — no repeated matrix multiplications crushing the signal==, so information placed at step 3 can survive to step 50. The limitation: a worker at station 50 can only see what's currently on the belt — they can't reach back to station 3 directly. That's the sequential bottleneck transformers eliminate.

#### The Transformer & Scaling Laws (2017–Present)

- **"Attention is All You Need"** (2017): Removed the sequence requirement entirely
- **Self-Attention**: Every word looks at every other word simultaneously, enabling the model to understand **global context** instantly
- **Scaling Laws**: As parameters and data increase, loss decreases in a predictable **power law**, driving the race for trillion-parameter models

> [!question] What's a power law?
> A mathematical relationship where one quantity scales as a fixed exponent of another: `y = c · x^α`. For LLMs (Kaplan et al., 2020), plotting model size vs. loss on a **log-log scale** yields a straight line — returns are diminishing but ==never hit a wall==. Each 10x increase in parameters buys a smaller absolute drop in loss, but the improvement never stops. This predictability gave labs the confidence to spend hundreds of millions training models they hadn't built yet — they could **forecast** the result before training.
>
> Power laws appear everywhere: earthquake magnitudes (Gutenberg-Richter), word frequency (Zipf's law — "the" vastly more common than "aardvark"), city sizes. The common pattern: **diminishing returns that never fully plateau**. For LLM scaling, the debate is always whether the next 10x spend is _worth it_, not whether it'll help.

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

> [!question] What is the MRKL architecture?
> MRKL (Karpas et al., 2022, AI21 Labs) is the ==blueprint for modern tool use== — it formalized the pattern before function calling APIs existed. The core insight: LLMs are bad at certain things (arithmetic, real-time facts, database lookups) but great at understanding _what you're asking for_ and _which tool would help_.
>
> The architecture combines a **central LLM as router** with **specialized expert modules**:
>
> - Calculator for math
> - Search engine for current facts
> - SQL engine for database queries
> - Weather API, calendar API, etc.
>
> The LLM decides which module to call, formulates the input, and integrates the result. For example, "What's the weather in Tokyo multiplied by the Euro exchange rate?" requires chaining WeatherAPI → ExchangeAPI → Calculator — no single component could answer it alone.
>
> A year after MRKL was published, OpenAI shipped function calling, Anthropic shipped tool use, and the pattern became standard. The ReAct loop is essentially MRKL in action — Thought/Action/Observation is how the router decides which expert to call and what to do with the result.

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
6. **Observation**: "The answer is 1,050,000."

- **Activity — Applying ReAct**: Pick a complex, open-ended problem (e.g., "plan me a 1-week trip to Paris on a 500 euro budget") and sketch out how an agent would approach it across all four cognitive components:
  1. **Planning**: How does the agent break this down?
  2. **Tool Use**: Which APIs/external tools are needed?
  3. **Memory**: What does it need to retrieve from the user's past data to succeed?
  4. **Perception**: What real-time data must it observe to make a decision?

> [!example] ReAct simulation: "Plan a 1-week trip to Paris on €500"
>
> **Planning — Task Decomposition:**
>
> - Allocate budget (lodging, food, transport, activities)
> - Find accommodation ≤ €250 for 7 nights
> - Find cheap flight/train
> - Plan daily activities (mix free + paid)
> - Check user's date constraints
>
> **The ReAct Loop:**
>
> - Thought: "I don't know departure city or dates." → Action: `AskUser(...)` → Observe: "Philadelphia, Mar 15–22"
> - Thought: "Need flight prices." → Action: `FlightAPI(PHL→CDG, Mar 15–22)` → Observe: €180 round-trip
> - Thought: "€320 left. Lodging next." → Action: `HostelAPI(Paris, Mar 15–22)` → Observe: Generator Hostel €28/night (€196 total)
> - Thought: "€124 left for food + activities. Check user preferences." → Action: `MemoryRetrieve("travel preferences")` → Observe: user previously searched "best museums in Europe" and "vegetarian restaurants Paris"
> - Thought: "They like museums, are vegetarian." → Action: `Search("cheap vegetarian restaurants Paris")` → Observe: falafel in Le Marais ~€6, Le Potager du Marais ~€12
> - Thought: "Need transport costs." → Action: `Search("Paris metro pass price")` → Observe: 10-ticket carnet €16.90
> - Thought: "Final budget: flights €180 + hostel €196 + transport €17 + food €84 + activities €16 = €493. €7 buffer." → Action: `Calculate(180+196+17+84+16)` → Observe: 493
>
> ==The loop isn't linear — the agent adapts==. When the flight cost €180 (high), it shifted to hostels and free activities. When memory surfaced "vegetarian," it changed the restaurant search. Each Observation reshapes the next Thought — that's the difference between an agent and a static planner.
>
> **Memory used:** user search history (museums, vegetarian), conversation context (departure city), cached tool results (prices for budget math)
>
> **Perception needed:** live flight prices, current hostel availability, current metro pricing, museum free-day schedules
