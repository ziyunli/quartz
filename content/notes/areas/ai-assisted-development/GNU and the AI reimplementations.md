---
title: "GNU and the AI reimplementations"
source: "https://antirez.com/news/162"
tags:
  - Blogmarks
  - ai-assisted-development
---

> [!info] AI-assisted annotations
> Discussion callouts and legal research with Claude Opus 4.6 via Claude Code.

Antirez argues that AI-powered reimplementation of software is legally and ethically the same process that GNU and Linux followed — just brutally faster. He's right about the productivity leveling, but hand-waves past structural risks for pre-traction projects and untested legal territory.

> [!question] How has this legal framework been tested in practice?
> The strongest U.S. precedent is ==_[Google v. Oracle](https://www.supremecourt.gov/opinions/20pdf/18-956_d18f.pdf)_ (2021)==, where the Supreme Court held 6-2 that reimplementing ~11,500 lines of Java API declarations for Android was fair use ([SCOTUSblog](https://www.scotusblog.com/case-files/cases/google-llc-v-oracle-america-inc/), [EFF](https://www.eff.org/cases/oracle-v-google)). This supports antirez's position — APIs can be reimplemented. But it only covers interface/declarations, not wholesale implementation copying.
>
> The cases currently testing AI specifically are:
>
> - ==_NYT v. OpenAI_== (filed Dec 2023, S.D.N.Y. case 1:23-cv-11195, pending) — tests whether _training_ on copyrighted content is infringement, a layer antirez doesn't touch
> - ==_[Doe v. GitHub](https://githubcopilotlitigation.com/)_== (Copilot lawsuit, filed Nov 2022, N.D. Cal.) — tests whether AI code generation violates open-source license attribution requirements; most claims were narrowed in 2024
> - The [EU AI Act](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32024R1689) (adopted June 2024) adds transparency obligations for GPAI providers, including respecting copyright opt-outs
>
> ==No case has directly tested antirez's scenario: "give an AI agent source code, ask it to reimplement differently."== The legal theory would stitch together Oracle v. Google + clean-room doctrine + whatever the training cases decide — but that combination is untested.
> ^legal-framework-tested

> [!warning] The source-fed approach breaks from the Stallman discipline — does that matter legally?
> Antirez describes two approaches: spec-driven (extract a specification, then reimplement in a fresh session) vs. source-fed (give the agent the code itself and ask it to diverge). He treats both as valid, but ==the source-fed approach is the opposite of Stallman's explicit rule: don't look at the source code==.
>
> For open-source code, there's no secrecy violation — the code is public. But the license question gets murky: if you feed GPL code into an agent and get a structurally different reimplementation, is the output a derivative work that inherits the license? Current OSS licenses weren't written with this process in mind. ==A court might treat spec-driven and source-fed reimplementation very differently even if the outputs look similar==, because the _process_ of how the agent was exposed to the original matters for determining derivation.
> ^source-fed-approach

> [!question] What if the real copy isn't the code but the theory?
> Peter Naur's "[Programming as Theory Building](https://pages.cs.wisc.edu/~remzi/Naur.pdf)" (1985) argues that the substance of a program isn't the code — it's the developer's mental model of how the problem domain maps to the solution. ==When you reimplement with AI, especially source-fed, you absorb and reuse the original developer's _theory_: which tradeoffs matter, where the abstractions live, what the edge cases are.== The code is structurally new but the theory can be substantially borrowed.
>
> This reframes Stallman's "don't look at the source" rule as deeper than legal protection — it forced GNU developers to ==build their own theory from specs==, which is why their tools ended up genuinely different in design, not just in code. It's also why antirez's own concession — "just reimplementing things without putting something novel inside will have modest value" — rings true. The code is new but the theory is hollow.
>
> Copyright law has no concept of "theory copying." It protects expressions, not understanding. But Naur's framework suggests there's a layer of intellectual debt in reimplementation that legal frameworks can't capture.
> ^theory-building

> [!warning] Pre-traction companies are most vulnerable to AI reimplementation
> Antirez frames reimplementation as universally fair, but he's mostly thinking about established projects (UNIX, mature OSS). For a startup or solo dev who shares an innovative approach ==before finding product-market fit==, the calculus is different. The original GNU/Linux reimplementations took _years_. If an AI agent can reimplement your novel approach in a weekend, ==the window between "share your idea" and "someone ships a clone with more resources" collapses dramatically==.
>
> This creates a catch-22: open-sourcing is the primary adoption strategy for developer tools, but it also exposes ideas at the most vulnerable moment. The result could be a chilling effect on early-stage sharing — the opposite of what antirez hopes AI will do for OSS.
> ^pre-traction-vulnerability

> [!question] Can OSS licenses express "share but don't train"?
> Antirez says "the copyright law is a common playfield: the rules are the same for all." But existing OSS licenses (MIT, Apache, GPL) were written to govern code _redistribution and use_, not _training_. ==They can't distinguish "use my code in your project" from "train on my code to generate new code."== Is a model trained on GPL code a "derivative work"? The license frameworks predate the use case entirely.
>
> The EU AI Act tries to address this with opt-out mechanisms, but enforcement stops at borders — US, Chinese, and Indian companies can easily work around EU-only protections. Some newer licenses (like AI2 ImpACT) attempt to fill the gap, but the mainstream OSS ecosystem has a conceptual hole here.
> ^oss-license-gap

> [!info] Antirez is right about productivity, hand-wavy about structural risks
> The core argument — ==AI greatly elevates the ceiling of individual and small-team productivity== — is correct and observable. Weekend OSS projects getting 10x output is real. Small groups competing with big corps on ideas is real.
>
> But "the rules are the same for all" does a lot of heavy lifting. Same rules don't mean fair outcomes when starting positions are unequal (a pre-traction startup vs. FAANG with distribution). The optimism works best for established OSS projects with communities; it's weaker for the pre-community phase where ideas are most exposed and moats haven't formed yet. ==Community and trust may be the strongest moat remaining — harder to clone a community than a codebase.==
> ^productivity-vs-risks
