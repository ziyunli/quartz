---
tags:
  - Blogmarks
---

> [!info] AI-assisted annotations
> Discussion synthesis and callouts with Claude Opus 4.6 via Claude Code.

HN discussion thread on the Claude Opus 4.7 release (April 16, 2026), with ~500+ comments covering community sentiment, practical configuration tips, and the growing Claude vs Codex debate.

Source: [Hacker News Discussion](https://news.ycombinator.com/item?id=47793411)

> [!question] What's the deal with Adaptive Thinking in Opus 4.7?
> ==Opus 4.7 only supports adaptive thinking — you cannot disable it or use fixed thinking budgets.== This is the dominant complaint in the thread. The model decides how much to "think" per request, and many users feel it consistently under-thinks on hard problems.
>
> - Anthropic's Boris acknowledged bugs with adaptive thinking on 4.6 but went silent after
> - The cynical read from multiple commenters (siva7, hbbio): adaptive thinking lets Anthropic control compute costs, not the user
> - pkilgore reports that disabling adaptive thinking + higher default thinking on 4.6 "finally got the quality I'm looking for"
> - For 4.7, users recommend: `/effort xhigh` to compensate, since you can't disable adaptive thinking
> - andai notes this may be an unsolved problem — GPT-5 had a similar "router" that was initially terrible at deciding when to use reasoning
>   ^adaptive-thinking-debate

> [!info] Practical Claude Code Configuration Tips
> ==Community-tested settings for getting the most out of Opus 4.7:==
>
> - `/effort xhigh` — default for 4.7 in Claude Code, but verify it's set
> - `CLAUDE_CODE_DISABLE_1M_CONTEXT=1` in settings.json env — smaller context, better output
> - `--thinking-display summarized` CLI flag — restores thinking summaries
> - Move memory and plans into the project directory for git visibility: set `autoMemoryDirectory` and `plansDirectory` in `.claude/settings.local.json`
> - Keep CLAUDE.md small; use slash commands/skills for detailed instructions
> - Periodically audit MEMORY.md — wrong memories cause major degradation
> - Use Plan mode liberally; hand off execution to subagents
> - Anti-sycophancy prompt: "prioritize facts and critical analysis over validation"
> - "Never ask questions or attempt to keep the conversation going" stops unsolicited suggestions
>   ^practical-config-tips

> [!warning] Context Bloat: The 1M Window is a Trap
> ==Multiple power users independently converge on the same advice: keep context small.==
>
> - rkuska: `CLAUDE_CODE_DISABLE_1M_CONTEXT=1` — "Opus is just worse with larger context"
> - pwinnski: manually disabled 1M context, caps at 200K, doesn't like going above 50%
> - JamesSwift: "I keep the default context extremely small and rely on invoked slash commands"
> - arcanemachiner: 4.7 seemed better than 4.6 at high context (275K vs 4.6's "dumb zone around 200K")
> - JohnMakin: wrong entries in MEMORY.md were silently degrading performance — auditing them was "like magic"
> - hombre_fatal: moving memory/plans into the project directory (visible in git status) made the agent read/set them more reliably
>   ^context-bloat-trap

> [!question] Why Are Thinking Traces Hidden Now?
> ==4.7 defaults to NOT including human-readable reasoning summaries== — you must explicitly request them.
>
> - The traces were always summarized by Haiku (a smaller model), not raw CoT — fasterthanlime notes you can tell because it sometimes says "I don't see any thought needing to be summarised"
> - The first ~500 tokens are raw thinking, then the summarizer kicks in (JoshuaDavid)
> - Widely attributed to anti-distillation: preventing competitors from training on Claude's reasoning chains
> - gck1 pushes back hard: "I have entire processes built on summaries of CoT. They provide tremendous value... The proof that thinking tokens are indeed useful is that Anthropic tries to hide them"
> - shawnz: thinking summaries signal when you've left things underspecified in the prompt — useful for prompt refinement even if not faithful to actual reasoning
> - To get them back in Claude Code: `--thinking-display summarized` CLI flag, or `claude --thinking-display summarized`
>   ^thinking-traces-hidden

> [!warning] Cybersecurity Refusals: Aggressive and Disruptive
> ==4.7 blocks legitimate security research, and the restrictions are retroactive to 4.6.==
>
> - Security researchers report being blocked mid-session when the model's own reasoning shifts from "code review" to "exploitation" — sigmarule calls this "AUP violation-based fuzzing"
> - The model injects "Not malware" annotations in thinking traces when reading normal codebases
> - RetpolineDrama: "4.7 is absolutely useless for binary/firmware analysis on our own products"
> - comboy's workaround: use language like "evaluate security" / "verify security" instead of "find vulnerabilities" — saying "this is not malware" actually increases classification risk
> - Kim_Bruning: "I can confirm from experience that reviewing your own code for vulnerabilities has fallen under prohibited uses"
> - Anthropic does provide a verification form at claude.com/form/cyber-use-case with ~24hr response time
> - OpenAI's Codex has similar restrictions — GPT-5.4 silently reroutes to GPT-5.2 for cybersecurity work unless verified
>   ^cybersecurity-refusals

> [!info] Claude vs Codex: Community Consensus
> ==Neither is universally better — they have complementary strengths.==
>
> - Claude (Opus): more elegant code, better at planning and new project creation, stronger front-end work, better tool interaction
> - Codex (GPT 5.4 xhigh): faster, cheaper, more literal, better at code review/debugging, more generous usage limits
> - antirez: "for low level coding, Codex with GPT 5.4-xhigh is really powerful"
> - vessenes: uses Claude for "broad strokes creation" and Codex for audit
> - andai's practical finding: Claude wrote detailed specs, Codex executed — "the current optimum seems to be having Claude write detailed specs and delegate to Codex"
> - merlindru: "GPT-5.4 needs explicit instructions not to take liberties" and "takes EVERYTHING you say at face value"
> - berkes: context engineering (skills, agents.md, subagents) matters more than raw model choice — "A Devstral with good skills performs far better than a blank Claude Code"
>   ^claude-vs-codex
