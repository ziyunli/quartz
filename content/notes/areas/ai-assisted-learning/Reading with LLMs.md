---
tags:
  - Blogmarks
---

> [!info] AI-assisted annotations
> Synthesis of three separate notes, cross-referencing, and integration of Keshav's framework with Claude Opus 4.6 via Claude Code.

A pattern emerging from multiple practitioners: use LLMs as active reading companions to engage with complex material more deeply and efficiently.

## Academic Origin: Keshav's Three-Pass Method

The multi-pass reading pattern predates LLMs by nearly two decades. [Keshav (2007)](https://doi.org/10.1145/1273445.1273458) proposed a systematic three-pass approach for reading academic papers:

1. **First pass** (5–10 min) — skim title, abstract, headings, conclusions. Answer the "5 C's": ==Category, Context, Correctness, Contributions, Clarity==. Decide whether to continue.
2. **Second pass** (~1 hour) — read with care but skip proofs and details. Focus on figures, diagrams, and key arguments. Jot down terms you don't understand.
3. **Third pass** (3–5 hours) — ==virtually re-implement the paper==: make the same assumptions as the authors and attempt to re-create the work. This reveals hidden assumptions and innovations.

The escalating depth — orient → comprehend → reconstruct — is the same structure that LLM-assisted readers independently converged on. The LLM effectively becomes a partner for passes 2 and 3: summarizing to confirm comprehension, then challenging your understanding through Q&A.

> [!question] The 5 C's as a structured prompt
> Keshav's first-pass questions (Category, Context, Correctness, Contributions, Clarity) work directly as an LLM prompt after skimming a paper. Ask the LLM to evaluate the paper against these five dimensions — it externalizes the assessment you'd normally do in your head, and surfaces gaps in your own reading.

## The Shared Pattern

Across [Karpathy](https://x.com/karpathy/status/1990577951671509438/?rw_tt_thread=True), [Alan Chan (Heptabase)](https://medium.com/heptabase/the-best-way-to-use-ai-for-learning-762c3467bdf1#fe23), and [Jeremy Howard (fast.ai)](https://www.fast.ai/posts/2026-01-21-reading-LLMs/index.html), the same core workflow appears:

1. **Parse source material** into LLM-friendly format (PDF/EPUB → markdown/text)
2. **Read it yourself first** — manual pass before involving the LLM
3. **Engage with LLM** — summarize, discuss, Q&A
4. **Synthesize** — take notes in your own words, build connections

## What Each Approach Adds

### Karpathy: 3-Pass Method

> I'm starting to get into a habit of reading everything (blogs, articles, book chapters,…) with LLMs. Usually pass 1 is manual, then pass 2 "explain/summarize", pass 3 Q&A.

Built [reader3](https://github.com/karpathy/reader3) to go chapter by chapter through EPUBs, copy-pasting to your favorite LLM. Notes that NotebookLM doesn't even support EPUB.

### Alan Chan: 5-Step Framework

Focused on learning knowledge that is "more complex, abstract, and challenging":

1. Parse the PDF
2. Create the Learning Materials
3. Read from the Whiteboard and Discuss with AI
4. Take Notes in Your Own Words
5. Visualize, Synthesize

The last two steps are distinct from Karpathy's approach — Chan treats note-taking and visualization as explicit phases, not just byproducts of the Q&A.

### Jeremy Howard: Context-Managed Close Reading

1. Convert PDFs to Markdown
2. Generate summaries of each chapter to use as context for the LLM
3. Instruct the LLM not to give spoilers
4. Ask questions as you read through the full text
5. At the end of each chapter, generate conversation overviews to carry forward as context
6. Optional: LLM asks questions to check understanding
7. Optional: create Anki cards with [fastanki](https://answerdotai.github.io/fastanki/)

The key insight is **context management across chapters** — summaries and conversation overviews accumulate so the LLM has growing context as you progress through the book. The "no spoilers" instruction is a nice touch for narrative works.

## In Practice

The workflows in this vault implement this pattern across different source types:

### Articles and Clippings (`studying-articles`)

- **Summarize pass** (from Karpathy's 3-pass method) — overview of key ideas before diving into Q&A
- **Interactive Q&A** — annotate with callouts, then publish as blogmarks or split into PARA topic files
- **Optional quiz** (from Jeremy Howard's active recall) — application-focused questions to solidify understanding

### Academic Papers (`reading-papers`)

Applies [[How to Read a Paper|Keshav's three-pass framework]] with LLM assistance at each stage. Each pass enforces a **reading gate** — the user must engage independently before the LLM deepens understanding (echoing Jeremy Howard's "no spoilers" principle).

- **First pass** — skim manually, then use the LLM to evaluate the 5 C's (Category, Context, Correctness, Contributions, Clarity). Explicit "worth continuing?" gate.
- **Second pass** — no spoilers: LLM clarifies terms and sections the user flags, walks through figures, and surfaces references for future reading. Does not summarize ahead.
- **Third pass** — "virtually re-implement" via adversarial Q&A: challenge assumptions, reconstruct arguments, identify gaps

Details and workflow are defined in the `reading-papers` skill.

### Shared emphasis

Both workflows emphasize **annotation and knowledge management** (callouts, transclusions, PARA organization) rather than just the reading itself. Context management across chapters is deferred to a future book-reading skill.
