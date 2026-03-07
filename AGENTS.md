# Quartz Vault

Obsidian vault published via Quartz to https://ziyunli.github.io/quartz/

## Project Structure

- Content lives under `content/`
- `content/private/` — NOT published to the public site
- Everything else under `content/` — published

## Cross-referencing Rules

- Private-to-private links: use Obsidian wikilinks `[[filename|display text]]`
- **Public-to-private links: use original source URLs (external links), NOT wikilinks** — private content won't resolve on the published site
- Public-to-public links: use wikilinks
- When private clippings and public blogmarks share the same filename, use folder path in transclusions to disambiguate: `![[blogmarks/filename#^block-id]]`

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
