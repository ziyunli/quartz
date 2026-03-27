# Quartz Vault

Obsidian vault published via Quartz to https://ziyunli.github.io/quartz/

- Default branch is `v4` — `master` holds the rendered GitHub Pages output (deploy commits only)

## Git & Safety

- `content/private/` is gitignored — it MUST NEVER be committed to the repo. Verify with `git status` before any commit.
- **No branches or worktrees** — this repo is Dropbox-synced. Creating branches or git worktrees will cause sync conflicts or data loss. Always work directly on `v4`.
- **Risky changes to `private/`**: if you need to make a destructive or large-scale edit to files under `content/private/`, copy the affected files first (e.g., `cp file.md file.md.bak`) so nothing is lost. Remove backups after verifying the result.

## Project Structure

- Content lives under `content/`
- `content/private/` — NOT published to the public site
- Everything else under `content/` — published

### Public (`content/notes/`)

PARA folders and collections, all published:

- `notes/projects/` — short-term efforts with clear outcomes and due dates
- `notes/areas/` — ongoing responsibilities requiring constant attention
  - `notes/areas/ai-assisted-development/` — LLM tooling, agentic patterns, vibe coding
  - `notes/areas/ai-assisted-learning/` — using LLMs for reading, studying, and knowledge acquisition
  - `notes/areas/economics/` — economic concepts and analysis
  - `notes/areas/llm/` — LLM architecture, training techniques, reasoning models
  - `notes/areas/llm-tooling/` — local model inference, hardware for AI, performance estimation
  - `notes/areas/self-improvement/` — productivity, learning, personal growth
- `notes/resources/` — catchall for anything not tied to a project or area
  - `notes/resources/business/` — company profiles, business strategy, industry analysis
- `notes/archive/` — inactive or outdated notes
- `notes/blogmarks/` — distilled annotations of external content
- `assets/` — public media assets (at `content/assets/`)
- Top-level notes in `notes/` are being gradually categorized into PARA folders

### Private (`content/private/`)

PARA folders and internal collections, never published:

- `private/projects/` — short-term efforts with clear outcomes and due dates
- `private/areas/` — ongoing responsibilities requiring constant attention
  - `private/areas/ai-assisted-development/` — private LLM tooling notes and prompts
  - `private/areas/economics/` — private economic notes
  - `private/areas/self-improvement/` — private productivity and growth notes
  - `private/areas/soccer/` — soccer research and cleats
- `private/resources/` — private catchall resources
- `private/archive/` — inactive or outdated private notes
- `private/books/` — book notes
- `private/clippers/` — raw web clippings (flat intake, stays here)
- `private/system-design-questions/` — system design interview questions for mock sessions
- `private/papers/` — academic papers and annotations
- `private/writings/` — drafts and reflections
- `private/assets/` — private media assets

## Obsidian CLI

- **Always use the Obsidian CLI for file operations** (create, move, rename, delete) — it maintains the link graph automatically. Never use raw `mv`, `rm`, or shell file operations on `.md` files unless the CLI can't handle them.
- Use `obsidian help` to see available actions when you operate this Obsidian Vault
- Vault name for CLI is `content`
- Use `obsidian move vault=content path="<from>" to="<dest-folder>/"` to move files — updates wikilinks automatically
- Use `obsidian create vault=content path="<path>" content="<text>"` to create files
- Use `obsidian rename vault=content path="<path>" name="<new-name>"` to rename files
- Use `obsidian delete vault=content path="<path>"` to delete files
- Destination folders must exist before moving (mkdir -p first)
- Fall back to shell commands only for files the CLI can't handle: filenames with colons (`:`), non-linkable files (.txt, .pdf)
- After editing, moving, or creating a note, check its link health:
  - `obsidian links` — verify outward links resolve
  - `obsidian backlinks` — verify inward links still work
  - `obsidian unresolved` — check for broken wikilinks
  - Fix any broken links caused by renames or moves

## Cross-referencing Rules

- For same-file heading links, use wikilinks `[[#Exact Heading Text]]` or `[[#Heading\|display]]` — standard Markdown anchors `[text](#slugified-heading)` don't resolve in Obsidian
- In table cells, escape the pipe in wikilink aliases: `[[#Heading\|display]]`
- Bold wraps the wikilink, not inside the alias: `**[[#Heading\|display]]**` not `[[#Heading\|**display**]]`
- Transclusions use `![[note]]` (wikilink syntax), NOT `![alt](file.md)` (Markdown image syntax)
- Private-to-private links: use Obsidian wikilinks `[[filename|display text]]`
- **Public-to-private links: use original source URLs (external links), NOT wikilinks** — private content won't resolve on the published site
- Public-to-public links: use wikilinks
- When private clippings and public blogmarks share the same filename, use folder path in transclusions to disambiguate: `![[notes/blogmarks/filename#^block-id]]` or `![[notes/areas/ai-assisted-development/filename#^block-id]]`

## Note Conventions

- Frontmatter uses `tags:` as YAML list
- Obsidian callout types: `[!question]`, `[!info]`, `[!warning]`, `[!example]`
- Use `==highlights==` for key takeaways inside callouts
- No tables inside blockquote callouts (breaks Obsidian rendering) — use bullet lists
- Place callouts contextually after the relevant content, not grouped at the end
- One concept per callout; keep them self-contained
- When research is used to write or enrich a note, always include citations with URLs or references (footnotes, inline links, or source list) — never present researched claims without attribution
- Escape literal `$` as `\$` in published content — Quartz interprets `$...$` as LaTeX math. Code blocks and inline code are safe.

## AI Disclosure

- When AI assists in editing a note, add a `[!info] AI-assisted annotations` callout after frontmatter
- Mention briefly what was helped (e.g., "callouts and cross-references") and include harness + model (e.g., "Claude Opus 4.6 via Claude Code")

## Quartz Commands

- `npx quartz build` — build the site
- `npx quartz build --serve` — build and serve locally with live reload
- `npx prettier ./content --check` — check content formatting
- `npx prettier ./content --write` — auto-format content
