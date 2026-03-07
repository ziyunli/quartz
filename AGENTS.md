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

## Note Conventions

- Frontmatter uses `tags:` as YAML list
- Obsidian callout types: `[!question]`, `[!info]`, `[!warning]`, `[!example]`
- Use `==highlights==` for key takeaways inside callouts
- No tables inside blockquote callouts (breaks Obsidian rendering) — use bullet lists
- Place callouts contextually after the relevant content, not grouped at the end
- One concept per callout; keep them self-contained
