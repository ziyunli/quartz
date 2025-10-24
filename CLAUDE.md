# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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
1. Notes are private by default, with polished notes promoted to public
2. Minimal use of tags (tags in Quartz can be confusing with space-separated capitalization)
3. Everything generally goes into `/notes`
4. Content is written "for me by default" - expect a casual, personal tone
5. More organized, public-facing content goes to the external blog (https://blog.ziyun.rocks/)

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
- **Highlights**: Readwise (https://readwise.io/@ziyun)
- **Reading list**: Readwise Reader (https://read.readwise.io/)
- **Hosting**: GitHub Pages
- **Generator**: Quartz v4

## Notes on the Quartz Framework

While the `quartz/` directory contains the framework code, avoid making changes unless absolutely necessary. If style tweaks are needed:
1. Prefer configuration changes in `quartz.config.ts` over code changes
2. Style changes should be in `quartz/styles/` or theme configuration
3. Component changes should only be made if a visual/structural change is required
