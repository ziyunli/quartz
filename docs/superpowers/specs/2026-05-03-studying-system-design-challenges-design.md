# Studying System Design Challenges — Skill Redesign

**Date:** 2026-05-03
**Type:** Edit existing skill
**Source skill:** `mock-system-design-interview`
**Target skill:** `studying-system-design-challenges`

## Goals

1. Rename the skill to match the gerund-plural pattern of sibling study skills (`studying-coding-challenges`, `studying-articles`, `studying-course-materials`).
2. Add a **solution study** mode alongside the existing **mock interview** mode, paralleling `studying-coding-challenges`.
3. Introduce a **working doc** the agent reads during the session, supporting three formats: markdown, Obsidian Canvas, Excalidraw.
4. Preserve all existing behavior: 4-step framework, hint system, evaluation rubric, post-session 5-step wrap-up.

## Non-goals

- No change to the question file format or the reference doc format.
- No change to the post-session retro structure for mock mode.
- No new system design content (this is a process/UX change, not a content change).

## Design

### Naming

`studying-system-design-challenges` — gerund + plural, matches existing study skills exactly.

### Modes

| Mode          | Behavior                                                                                                                                                                            |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `mock`        | Existing 4-step framework: Requirements → HLD → Deep Dive → Wrap-up. Coaching or simulation sub-mode. Full evaluation rubric at end.                                                |
| `study` (new) | Walks the question's Reference doc section by section. User attempts each section first, then reference is shared, then alternatives are probed. Lighter wrap-up, no hire decision. |

### Setup flow

1. Ask question file path (existing — directory or file)
2. **NEW**: Ask `mock` or `study`
3. Ask time target (default 45 min for mock, 30 min for study)
4. **NEW** (mock mode): Ask working doc — paste path OR scaffold (`markdown` / `canvas` / `excalidraw`, default `markdown`). Scaffolded path: `<Question Name> - Working <YYYY-MM-DD>.<ext>` in the question's folder.
5. **NEW** (study mode): Working doc is offered but optional ("want a doc to sketch as we discuss?"). Same path options, same default.

### Working doc — read cadence

Agent does NOT re-read the doc on every turn. Reads happen at:

- **Auto** at session start (see if user pre-populated)
- **Auto** at each step transition: Requirements → HLD → Deep Dive → Wrap-up
- **On request** when user says "look at the doc" / "I just added X" / "as you can see here"

### Working doc — format-specific reading

| Format                        | How agent reads                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Markdown (`.md`)              | Read file directly. Cheap, every read.                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Canvas (`.canvas`)            | Read JSON, extract nodes (boxes/labels) and edges (connections).                                                                                                                                                                                                                                                                                                                                                                                       |
| Excalidraw (`.excalidraw.md`) | **Default:** read `## Text Elements` section (labels only). **At step transitions / on request:** prompt user to export PNG via the Excalidraw plugin (`Cmd+P` → "Export PNG") to a sibling path `<same-basename>.png` in the same folder, then read that PNG with vision. Falls back to labels-only if export is skipped or the PNG is missing/stale, with explicit disclaimer ("walk me through the connections — I can see labels but not layout"). |

### Study mode workflow

```
Phase 0 — Reading check ("read the Reference doc?")
   ↓
Phase 1 — Section walk (Requirements → HLD → Deep Dive Topics → Wrap-Up Prompts)
            for each section: user attempts → reference shared → alternatives probed
   ↓
Phase 2 — Quiz (optional, 3-5 application questions)
   ↓
Phase 3 — Wrap up (light retro, see below)
```

### Wrap-up changes

Existing 5 steps (2a–2e) preserved. One new step is prepended; two existing steps are modified.

**A. NEW step 0 (runs before existing 2a): working doc handling**

Ask: "Working doc — keep / discard / rename?"

- `keep`: stays in question's folder; retro wikilinks to it
- `discard`: agent deletes via Obsidian CLI; retro records the choice but does not wikilink
- `rename`: ask new name, move via CLI; retro wikilinks to the renamed file

**B. MODIFIED 2b: Retro structure adapts to mode**

- **Mock mode**: existing structure (per-step sections, evaluation rubric, hire decision, priority areas)
- **Study mode**: lighter structure
  - Setup block (question wikilink, mode = `study`, time target, date, working doc wikilink if kept)
  - Per-section notes (Requirements / HLD / Deep Dive Topics / Wrap-Up Prompts): what user got, what reference added, alternatives discussed
  - Study callouts placed contextually (`[!question]` / `[!warning]` / `[!info]` / `[!example]`)
  - Key insights to remember
  - Comparison to prior sessions
  - **No** evaluation rubric, **no** hire decision

**C. MODIFIED 2c + 2d: Mode noted in journal entries and Anki**

- 2c (System Design Retro Journal): add `mode: mock | study` to entry template
- 2d (Anki cards): study-mode cards focus on **why** of design choices (tradeoffs, alternatives, failure modes) over gotchas-from-mistakes

### What stays unchanged

- 4-step framework structure (Requirements / HLD / Deep Dive / Wrap-up) for mock mode
- Coaching vs Simulation sub-mode behavior
- Progressive Hint System (4 levels)
- Evaluation Rubric (6 dimensions, 1-4 scoring) for mock mode
- Question file format
- 2a (annotate question file metadata-only)
- 2b retro file naming convention
- 2c (System Design Retro Journal update)
- 2d (Anki via `accelerated-learning:creating-anki-cards`)
- 2e (save question file from ad-hoc sources, including reference doc generation with mermaid)
- Red flags list

## Migration

The existing skill directory is `mock-system-design-interview` (in both `.claude/skills/` and `.agents/skills/`). The two copies must stay identical (per current setup — verified via `diff -r`).

Migration steps:

1. Rename `mock-system-design-interview/` → `studying-system-design-challenges/` in both locations
2. Update `name:` frontmatter to `studying-system-design-challenges`
3. Update `description:` to match the new dual-mode behavior
4. Apply the design changes above

No external references to the old name need to be updated (skill is invoked by Claude reading descriptions, not by hard-coded references in other notes — verified by grepping the vault for `mock-system-design-interview`).

## Risks & Open Questions

| Risk                                                     | Mitigation                                                                                           |
| -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| Excalidraw PNG export friction interrupts interview flow | Make it optional + step-transition-only; labels-only default works for most discussion               |
| Polyglot doc complexity confuses setup                   | Single AskUserQuestion at setup with three explicit options; default = markdown if user is unsure    |
| Study mode and mock mode wrap-ups diverge too much       | Share the structural skeleton (setup block, callouts, comparison); only the evaluation block differs |
| Two skill directories drift out of sync                  | Document the dual-location requirement in the skill itself; verify with `diff -r` after edits        |

## Success Criteria

- Skill renames cleanly in both `.claude/skills/` and `.agents/skills/` and the two copies remain identical.
- A mock session with markdown working doc completes the 4-step flow and produces a retro that wikilinks to the working doc.
- A study session with no working doc completes the section walk and produces a study-mode retro (no rubric).
- An Excalidraw working doc session triggers a PNG export prompt at HLD → Deep Dive transition and the agent successfully reads the PNG.
- Description changes alone are sufficient for Claude to find the skill from prompts like "let's do system design practice" or "walk me through this system design solution."
