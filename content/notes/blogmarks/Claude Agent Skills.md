---
tags:
  - Blogmarks
created: 2025-12-03
---

From [Equipping agents for the real world with Agent Skills | Anthropic](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills):

Think of them like an onboarding guide you'd give a new hire—structured documentation that helps them understand how to do specific tasks within your organization's context.

> A skill is a directory containing a SKILL.md file that contains organized folders of instructions, scripts, and resources that give agents additional capabilities.

The key insight here is the **layered loading approach**—not everything needs to be in context all the time:

1. **Frontmatter** - Always loaded (metadata, triggers)
2. **SKILL.md content** - Dynamically loaded when skill triggers match
3. **Bundled files** - Loaded on-demand as needed

> A SKILL.md file must begin with YAML Frontmatter that contains a file name and description, which is loaded into its system prompt at startup.
>
> ...skills can bundle additional files within the skill directory and reference them by name from SKILL.md

Skills can also include executable scripts for deterministic outputs:

> Skills can also include code for Claude to execute as tools at its discretion based on the nature of the task.

> Start with evaluation: Identify specific gaps in your agents' capabilities by running them on representative tasks and observing where they struggle or require additional context. Then build skills incrementally to address these shortcomings.

Don't build skills speculatively. Watch where agents fail, then build skills to fill those gaps.

---

_Edited by Claude Code (claude-opus-4-5-20251101)_
