# AGENTS.md

## Project Overview

This is a digital garden (knowledge garden) built with Quartz, a static site generator. The primary work happens in the `content/` directory where Markdown notes are written and organized. The site is deployed to GitHub Pages at https://ziyunli.github.io/quartz/.

**Important**: This repository is primarily for content creation, not framework development. The Quartz framework code in `quartz/` should generally not be modified except for minor style tweaks.

## Content Structure

The `content/` directory contains:

- **`notes/`** - Collection of notes
- **`links/`** - Collection of links to blog posts and articles with comments and notes
- **`assets/`** - Images and other media files
- **`index.md`** - Homepage of the site
- **`.obsidian/`** - Obsidian editor configuration (ignored in builds)

### Content Organization Principles

From the site owner's knowledge garden philosophy:

1. **Purpose**: This garden tracks notes and summaries from books and articles
   - LLMs (Claude Code, OpenAI Codex, Google Gemini) are used to organize content and serve as personal assistant/information retrieval tools
2. **Tone**: Content is written "for me by default" - expect a casual, personal tone

## LLM Agent Guidelines

When working with content in this knowledge garden, LLM agents should:

1. **Content Creation**:

   - Help organize notes and summaries
   - Serve as a personal assistant for information retrieval
   - Generate tags sparingly when needed for categorization

2. **Respecting Direct Quotes**:

   - NEVER modify files tagged with `Quotes`, `do-not-edit`, or `Transcripts`
   - Direct quotes within a file should remain untouched

3. **Tag Generation**:

   - Generate tags only when explicitly requested or when they add clear value
   - Keep tags minimal and focused on categorization/discoverability
   - Avoid over-tagging as it creates maintenance burden

4. **LLM Edit Attribution**:
   - When editing content for fluency, grammar, or clarity, add a footnote at the end of the file
   - Format: `*Edited by Claude (model-id)*` (e.g., `*Edited by Claude (claude-sonnet-4-5-20250929)*`)
   - Place the footnote after a horizontal rule (`---`) at the end of the content

## Working with Content

### Content Format

All content files are Markdown (`.md`) with YAML frontmatter. Example:

```markdown
---
title: Your Note Title
enableToc: true
draft: false
created: 2023-09-29
tags:
  - your-tag
---

Your content here...
```

**Frontmatter fields:**

- `title` - Page title (optional, defaults to filename)
- `enableToc` - Show table of contents (default: true)
- `draft` - If true, page won't be published
- `tags` - List of tags (use sparingly per content philosophy)
- `created` - Created date (optional, defaults to file creation date if not provided)

### Obsidian Features

The site is edited with Obsidian, so Obsidian-flavored Markdown is supported:

- Wikilinks with `[[]]`
- Embedded notes: `![[Other Note]]`
- Block references
- Callouts/admonitions

### Ignored Patterns

The following are excluded from builds (configured in `quartz.config.ts`):

- `private/` directory
- `templates/` directory
- `.obsidian/` directory

## Notes on the Quartz Framework

While the `quartz/` directory contains the framework code, avoid making changes unless absolutely necessary. If style tweaks are needed:

1. Prefer configuration changes in `quartz.config.ts` over code changes
2. Style changes should be in `quartz/styles/` or theme configuration
3. Component changes should only be made if a visual/structural change is required
