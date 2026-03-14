---
tags:
  - Blogmarks
---

> [!info] AI-assisted annotations
> Synthesis of three separate notes and cross-referencing with Claude Opus 4.6 via Claude Code.

A pattern emerging from multiple practitioners: use LLMs as active reading companions to engage with complex material more deeply and efficiently.

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

The `studying-articles` skill in this vault is an implementation of this pattern for articles and clippings. It incorporates:

- **Summarize pass** (from Karpathy's 3-pass method) — overview of key ideas before diving into Q&A
- **Interactive Q&A** — annotate with callouts, then publish as blogmarks or split into PARA topic files
- **Optional quiz** (from Jeremy Howard's active recall) — application-focused questions to solidify understanding

The main difference from the approaches above is that our workflow emphasizes **annotation and knowledge management** (callouts, transclusions, PARA organization) rather than just the reading itself. Context management across chapters is deferred to a future book-reading skill.
