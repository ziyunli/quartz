# Quartz Vault

Obsidian vault published via Quartz to https://ziyunli.github.io/quartz/

- Default branch is `v4` — `master` holds the rendered GitHub Pages output (deploy commits only)

## Project Structure

- Content lives under `content/`
- `content/private/` — NOT published to the public site
- Everything else under `content/` — published

### PARA folders (both public and private)

- `projects/` — short-term efforts with clear outcomes and due dates
- `areas/` — ongoing responsibilities requiring constant attention
- `resources/` — catchall for anything not tied to a project or area
- `archive/` — inactive or outdated notes

### Notes hierarchy

- `notes/` — public general notes, plus nested subfolders:
  - `notes/blogmarks/` — distilled annotations of external content
  - `notes/reading/` — book notes
- `private/notes/` — private general notes, plus nested subfolders:
  - `private/notes/clippers/` — raw web clippings
  - `private/notes/books/` — book notes
  - `private/notes/prompts/` — prompt templates
  - `private/notes/soccer/` — soccer research and cleats
- `private/writings/` — drafts and reflections

### Other folders

- `asset/` — public media assets
- `private/assets/` — private media assets

## Obsidian CLI

- Use `obsidian help` to see available actions when you operate this Obsidian Vault
- Vault name for CLI is `content`
- Use `obsidian move vault=content path="<from>" to="<dest-folder>/"` to move files — updates wikilinks automatically
- Destination folders must exist before moving (mkdir -p first)
- Can't handle filenames with colons (`:`) — fall back to `mv` for non-linkable files (.txt, .pdf)

## Cross-referencing Rules

- Transclusions use `![[note]]` (wikilink syntax), NOT `![alt](file.md)` (Markdown image syntax)
- Private-to-private links: use Obsidian wikilinks `[[filename|display text]]`
- **Public-to-private links: use original source URLs (external links), NOT wikilinks** — private content won't resolve on the published site
- Public-to-public links: use wikilinks
- When private clippings and public blogmarks share the same filename, use folder path in transclusions to disambiguate: `![[notes/blogmarks/filename#^block-id]]`

## Note Conventions

- Frontmatter uses `tags:` as YAML list
- Obsidian callout types: `[!question]`, `[!info]`, `[!warning]`, `[!example]`
- Use `==highlights==` for key takeaways inside callouts
- No tables inside blockquote callouts (breaks Obsidian rendering) — use bullet lists
- Place callouts contextually after the relevant content, not grouped at the end
- One concept per callout; keep them self-contained

## AI Disclosure

- When AI assists in editing a note, add a `[!info] AI-assisted annotations` callout after frontmatter
- Mention briefly what was helped (e.g., "callouts and cross-references") and include harness + model (e.g., "Claude Opus 4.6 via Claude Code")
