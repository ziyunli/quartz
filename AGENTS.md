# AGENTS.md

## Project Overview

This is a digital garden (knowledge garden) built with Quartz, a static site generator. The primary work happens in the `content/` directory where Markdown notes are written and organized. The site is deployed to GitHub Pages at https://ziyunli.github.io/quartz/.

**Important**: This repository is primarily for content creation, not framework development. The Quartz framework code in `quartz/` should generally not be modified except for minor style tweaks.

## Content Structure

The `content/` directory contains:

- **`notes/`** - Collection of notes, and links to blog posts and articles with comments and notes
  - `Blogmarks` are links with a title, URL, short snippet of commentary and a “via” link where appropriate that I learn from Simon Willison's [link blog](https://simonwillison.net/2024/Dec/22/link-blog/) idea.
  - `Quotes` are short snippets  from books, articles, or other sources.
  - `Transcripts` are verbatim recordings of conversations, lectures, or other spoken content that usually don't have a transcript elsewhere online.
- **`assets/`** - Images and other media files
- **`index.md`** - Homepage of the site
- **`.obsidian/`** - Obsidian editor configuration (ignored in builds)

### Content Organization Principles

From the site owner's knowledge garden philosophy:

1. **Purpose**: This garden tracks notes and summaries from books and articles
   - LLMs (Claude Code, OpenAI Codex, Google Gemini) are used to organize content and serve as personal assistant/information retrieval tools
2. **Tone**: Content is written "for me by default" - expect a casual, personal tone

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
