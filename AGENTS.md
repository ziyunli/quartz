# AGENTS.md

## Project Overview

This is a digital garden (knowledge garden) built with Quartz, a static site generator. The primary work happens in the `content/` directory where Markdown notes are written and organized. The site is deployed to GitHub Pages at https://ziyunli.github.io/quartz/.

**Important**: This repository is primarily for content creation, not framework development. The Quartz framework code in `quartz/` should generally not be modified except for minor style tweaks.

## Content Structure

The `content/` directory contains:

- **`notes/`** - Main collection of notes and articles (most work happens here)
- **`reading/`** - Reading-related content (private by default)
- **`writing/`** - Writing-related content (private by default)
- **`templates/`** - Templates for new content
- **`assets/`** - Images and other media files
- **`index.md`** - Homepage of the site
- **`.obsidian/`** - Obsidian editor configuration (ignored in builds)

### Content Organization Principles

From the site owner's knowledge garden philosophy:

1. **Purpose**: This garden tracks notes and summaries from books and articles
   - LLMs (Claude Code, OpenAI Codex, Google Gemini) are used to organize content and serve as personal assistant/information retrieval tools
2. **Readwise Integration**: Highlights from [Readwise](https://readwise.io/@ziyun) should be:
   - Minimal and selective
   - Wisdom that withstands the test of time
   - Understandable without extensive context
   - Either quotes or individual files tagged with `Quotes`
3. **Minimal Tag Usage**:
   - Quartz renders tags in space-separated, first-word-capitalized format (can be confusing)
   - Tags haven't proven helpful for information retrieval and require maintenance effort
   - LLMs should generate tags when needed
   - Tags are primarily for categorization and discoverability
4. **Content Privacy**: Notes are private by default, with polished notes promoted to public
5. **Default Location**: Everything generally goes into `/notes`
6. **Tone**: Content is written "for me by default" - expect a casual, personal tone
7. **External Blog**: More organized, public-facing content goes to https://blog.ziyun.rocks/

## LLM Agent Guidelines

When working with content in this knowledge garden, LLM agents should:

1. **Content Creation**:

   - Help organize notes and summaries from books/articles
   - Serve as a personal assistant for information retrieval
   - Generate tags sparingly when needed for categorization

2. **Respecting `Quotes` Tags**:

   - NEVER modify files tagged with `Quotes`
   - These are typically Readwise highlights or direct quotes that should remain untouched

3. **Tag Generation**:

   - Generate tags only when explicitly requested or when they add clear value
   - Keep tags minimal and focused on categorization/discoverability
   - Avoid over-tagging as it creates maintenance burden

4. **Content Quality**:
   - When helping with highlights or quotes, ensure they:
     - Can withstand the test of time
     - Are understandable without extensive context
   - Maintain a casual, personal tone unless editing for the external blog

5. **LLM Edit Attribution**:
   - When editing content for fluency, grammar, or clarity, add a footnote at the end of the file
   - Format: `*Edited by Claude (model-id)*` (e.g., `*Edited by Claude (claude-sonnet-4-5-20250929)*`)
   - Place the footnote after a horizontal rule (`---`) at the end of the content

## Working with Content

### Building and Serving

```bash
# Build and serve with live reload (most common during content writing)
npx quartz build --serve

# Just build the site
npx quartz build

# Sync content with remote repository
npx quartz sync
```

### Content Format

All content files are Markdown (`.md`) with YAML frontmatter. Example:

```markdown
---
title: Your Note Title
enableToc: true
draft: false
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
- `date` - Custom date (optional, defaults to file creation date)

### Links

Quartz supports multiple link formats:

- **Wikilinks**: `[[Page Name]]` or `[[Page Name|Display Text]]`
- **Markdown links**: `[Display Text](page-name.md)` or relative paths
- Links are resolved using "shortest path" strategy (configured in `quartz.config.ts`)

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

## Configuration

### Main Config (`quartz.config.ts`)

Current site configuration:

- **Title**: "🪴 Ziyun's Backyards"
- **Base URL**: ziyunli.github.io/quartz
- **Analytics**: Plausible
- **Features**: SPA mode enabled, popovers enabled
- **Default date type**: created

### Layout Config (`quartz.layout.ts`)

Defines the visual layout with components like:

- **Left sidebar**: PageTitle, Search, Darkmode, RecentNotes (recent notes from `/notes`)
- **Right sidebar**: TableOfContents, Graph, Backlinks
- **Footer**: Links to GitHub and blog

### Style Customizations

For minor style tweaks, the main files are:

- **`quartz.config.ts`** - Theme colors under `theme.colors` (lightMode and darkMode)
- **`quartz/styles/`** - Custom CSS/SCSS files
- **Typography**: Header (Schibsted Grotesk), Body (Source Sans Pro), Code (IBM Plex Mono)

## Common Tasks

### Creating New Content

1. Create a new `.md` file in `content/notes/` (or appropriate directory)
2. Add frontmatter with title and any metadata
3. Write content using Markdown/Obsidian syntax
4. Preview with `npx quartz build --serve`

### Publishing Updates

1. Build the site: `npx quartz build`
2. Commit and push changes to repository
3. GitHub Pages will automatically deploy

### Finding Related Notes

The site features:

- **Graph view** - Visual network of linked notes
- **Backlinks** - Shows which notes link to the current note
- **Search** - Full-text search across all content
- **Recent notes** - Shows latest notes from `/notes` directory

## Workflow Tools

- **Editor**: Obsidian (https://obsidian.md/)
- **Hosting**: GitHub Pages
- **Generator**: Quartz v4

## Notes on the Quartz Framework

While the `quartz/` directory contains the framework code, avoid making changes unless absolutely necessary. If style tweaks are needed:

1. Prefer configuration changes in `quartz.config.ts` over code changes
2. Style changes should be in `quartz/styles/` or theme configuration
3. Component changes should only be made if a visual/structural change is required
