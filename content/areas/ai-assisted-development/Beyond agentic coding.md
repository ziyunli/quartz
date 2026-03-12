---
tags:
  - Blogmarks
---

> [!info] AI-assisted annotations
> Discussion notes and cross-references from studying [Beyond Agentic Coding](https://haskellforall.com/2026/02/beyond-agentic-coding) by Gabriella Gonzalez. Added with Claude Opus 4.6 via Claude Code.

Gonzalez argues that chat-based agentic coding tools break developer flow state and proposes **calm technology** as the design framework for better AI-assisted tooling.

> [!info] Origins of Calm Technology
> Calm technology traces back to Mark Weiser's work at Xerox PARC in the 1990s on **ubiquitous computing** — the idea that technology should "weave itself into the fabric of everyday life until it is indistinguishable from it." The key conceptual move is ==information should transition smoothly from the periphery to the center of attention==, not through interrupts.
> ^origins-of-calm-tech

> [!question] Can background agents ever be "calm"?
> The article's examples are all synchronous and small-scoped (inlay hints, next-edit suggestions). But a common real-world pattern is firing off multiple agents in parallel, each returning at different times — creating multiple context switches. Calm technology would suggest: ==results should accumulate quietly and be pulled into focus at natural breakpoints you choose==, not pushed via interrupts when agents finish. Think CI dashboard (you check when ready) vs. Slack notifications (they tap your shoulder). Batching re-engagement at your own pace is key.
> ^background-agents-calm

> [!question] What would make async agents actually calm?
> Three properties must hold **simultaneously**:
>
> - **Full autonomy** — the agent doesn't stop to ask clarifying questions mid-task, eliminating the "stay interruptible" burden
> - **Sandboxed evolution** — the agent works in isolation (worktrees, containers) so you don't monitor it for safety, only for results
> - **Legible progress signals** — structured peripheral indicators (tests passing, scope narrowing) rather than chat logs requiring focused reading
>
> ==Remove any one leg and the stool falls==: autonomous without sandbox is dangerous, sandboxed without progress signals is a black box, legible but not autonomous still interrupts you. The analogy: delegating to a junior engineer who has their own dev environment and posts to a dashboard, vs. pair programming with someone who keeps tapping your shoulder.
> ^async-agents-calm

> [!warning] The unsolved problem: intent alignment signals
> Progress on **correctness** can be signaled peripherally (test counts, type checks, linting). But progress on **intent** — "is it solving the problem the way I'd want?" — may inherently require focused attention. A fully green test suite built on the wrong abstraction is worse than a red one on the right track. The best we might get is ==reducing the review surface area==: instead of reading 500 lines of diff, you review 3 architectural decisions the agent flagged as uncertain. That's still an interrupt, but a much smaller one. This may be where calm technology meets a fundamental limit.
> ^intent-alignment

> [!info] The two paradigms of AI-assisted coding
> The article implicitly contrasts two paradigms:
>
> - **Inline/synchronous**: hundreds of tiny, calm assists woven into your editing flow (next-edit suggestions, semantic facets, file lenses). The AI never becomes the center of attention.
> - **Async/delegated**: fire off large tasks to background agents and review results later. Currently breaks flow, but could become calm if agents achieve full autonomy + sandboxing + legible progress.
>
> These aren't mutually exclusive — the strongest workflow may combine both, using inline assists for moment-to-moment coding and sandboxed agents for well-scoped background tasks where ==the review cost is deliberately minimized== (e.g., automated commit splitting, structured PR summaries).
> ^two-paradigms

> [!info] Related reading
>
> - [[Build To Last]] — Chris Lattner and Jeremy Howard's interview on software craftsmanship vs. AI-generated code. Lattner's "tight iteration loops" principle is the systems-programming equivalent of calm technology: ==fast feedback keeps the human engaged and in flow==.
> - [[../../areas/ai-assisted-development/Agentic Engineering Patterns - Linear walkthroughs]] — Simon Willison's "Linear Walkthroughs" takes the opposite approach: vibe code first, then have the agent teach you what it built. The walkthrough itself is calm (passive, unobtrusive learning), but the vibe coding session that preceded it is exactly what Gonzalez critiques here.
> - [[../../private/projects/Solve-It-2025/Solve It - 2025]] — Jeremy Howard's "Solve It" method arrives at the same conclusion from the practitioner side: the human must stay in direct contact with the code. His "inspect every output" workflow is a calm technology pattern in practice — the AI augments rather than mediates.
>   ^related-reading
