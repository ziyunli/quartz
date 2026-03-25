---
title: "Claude Code Cheat Sheet"
source: "https://cc.storyfox.cz/"
author:
published: 2026-03-23
created: 2026-03-24
description: Comprehensive reference for Claude Code keyboard shortcuts, slash commands, CLI flags, configuration, and features.
tags:
  - "clippings"
  - "claude-code"
---

## Keyboard Shortcuts

### General Controls

| Shortcut  | Action                                                    |
| --------- | --------------------------------------------------------- |
| `Ctrl+C`  | Cancel input/generation                                   |
| `Ctrl+D`  | Exit session                                              |
| `Ctrl+L`  | Clear screen                                              |
| `Ctrl+O`  | Toggle verbose output                                     |
| `Ctrl+R`  | Reverse search history                                    |
| `Ctrl+G`  | Open prompt in editor                                     |
| `Ctrl+B`  | Background running task                                   |
| `Ctrl+T`  | Toggle task list                                          |
| `Ctrl+S`  | Stash prompt (run slash command mid-input, auto-restores) |
| `Ctrl+V`  | Paste image                                               |
| `Ctrl+F`  | Kill background agents (×2)                               |
| `Ctrl+_`  | Undo typing (readline)                                    |
| `Esc Esc` | Rewind / undo                                             |

### Mode Switching

| Shortcut | Action                 |
| -------- | ---------------------- |
| `⇧Tab`   | Cycle permission modes |
| `⌥P`     | Switch model           |
| `⌥T`     | Toggle thinking        |

### Input

| Shortcut      | Action                |
| ------------- | --------------------- |
| `\` + `Enter` | Newline (quick)       |
| `Ctrl+J`      | Newline (control seq) |

### Prefixes

| Prefix | Action                      |
| ------ | --------------------------- |
| `/`    | Slash command               |
| `!`    | Direct bash                 |
| `@`    | File mention + autocomplete |

### Session Picker (via `/resume`)

| Key  | Action          |
| ---- | --------------- |
| `↑↓` | Navigate        |
| `←→` | Expand/collapse |
| `P`  | Preview         |
| `R`  | Rename          |
| `/`  | Search          |
| `A`  | All projects    |
| `B`  | Current branch  |

## MCP Servers

### Add Servers

| Flag                | Transport     |
| ------------------- | ------------- |
| `--transport stdio` | Local process |
| `--transport sse`   | Remote SSE    |

### Scopes

| File             | Scope                |
| ---------------- | -------------------- |
| `.claude.json`   | Local (per project)  |
| `.mcp.json`      | Project (shared/VCS) |
| `~/.claude.json` | User (global)        |

### Manage

| Command            | Action           |
| ------------------ | ---------------- |
| `/mcp`             | Interactive UI   |
| `claude mcp list`  | List all servers |
| `claude mcp serve` | CC as MCP server |

Elicitation: servers can request input mid-task (NEW)

## Slash Commands

### Session

| Command            | Action                                   |
| ------------------ | ---------------------------------------- |
| `/clear`           | Clear conversation                       |
| `/compact [focus]` | Compact context                          |
| `/resume`          | Resume/switch session                    |
| `/rename [name]`   | Name current session                     |
| `/branch [name]`   | Branch conversation (`/fork` alias)      |
| `/cost`            | Token usage stats (API key billing only) |
| `/context`         | Visualize context (grid)                 |
| `/diff`            | Interactive diff viewer                  |
| `/copy`            | Copy last response                       |
| `/export`          | Export conversation                      |

### Config

| Command           | Action                                   |
| ----------------- | ---------------------------------------- |
| `/config`         | Open settings                            |
| `/model [model]`  | Switch model (←→ effort)                 |
| `/fast [on\|off]` | Toggle fast mode                         |
| `/vim`            | Toggle vim mode                          |
| `/theme`          | Change color theme                       |
| `/permissions`    | View/update permissions                  |
| `/effort [level]` | Set effort (low/med/high/max/auto) (NEW) |
| `/color [color]`  | Set prompt-bar color                     |
| `/keybindings`    | Customize keyboard shortcuts             |
| `/terminal-setup` | Configure terminal keybindings           |

### Tools

| Command           | Action                |
| ----------------- | --------------------- |
| `/init`           | Create CLAUDE.md      |
| `/memory`         | Edit CLAUDE.md files  |
| `/mcp`            | Manage MCP servers    |
| `/hooks`          | Manage hooks          |
| `/skills`         | List available skills |
| `/agents`         | Manage agents         |
| `/chrome`         | Chrome integration    |
| `/reload-plugins` | Hot-reload plugins    |
| `/add-dir <path>` | Add working directory |

### Special

| Command            | Action                                       |
| ------------------ | -------------------------------------------- |
| `/btw <question>`  | Side question (no context)                   |
| `/plan [desc]`     | Plan mode (+ auto-start)                     |
| `/loop [interval]` | Schedule recurring task                      |
| `/voice`           | Push-to-talk voice (20 langs)                |
| `/doctor`          | Diagnose installation                        |
| `/stats`           | Usage streaks & prefs                        |
| `/insights`        | Analyze sessions report (highly recommended) |
| `/desktop`         | Continue in Desktop app                      |
| `/remote-control`  | Bridge to claude.ai/code (`/rc`) (NEW)       |
| `/usage`           | Plan limits & rate status                    |
| `/schedule`        | Cloud scheduled tasks                        |
| `/security-review` | Security analysis of changes                 |
| `/help`            | Show help + commands                         |
| `/feedback`        | Submit feedback (alias: `/bug`)              |
| `/release-notes`   | View full changelog                          |
| `/stickers`        | Order stickers!                              |

## CLAUDE.md

### Locations

| Path                   | Scope                   |
| ---------------------- | ----------------------- |
| `./CLAUDE.md`          | Project (team-shared)   |
| `~/.claude/CLAUDE.md`  | Personal (all projects) |
| `/etc/claude-code/`    | Managed (org-wide)      |
| `.claude/rules/*.md`   | Project rules           |
| `~/.claude/rules/*.md` | User rules              |
| `paths:` frontmatter   | Path-specific rules     |
| `@path/to/file`        | Import in CLAUDE.md     |

### Auto Memory

| Path                                | Description                  |
| ----------------------------------- | ---------------------------- |
| `~/.claude/projects/<proj>/memory/` | Per-project memory directory |
| `MEMORY.md` + topic files           | Auto-loaded into context     |

## Plan Mode

| Item                     | Description                        |
| ------------------------ | ---------------------------------- |
| `⇧Tab`                   | Cycle: Normal → Auto-Accept → Plan |
| `--permission-mode plan` | Start in plan mode                 |
| `⌥T`                     | Toggle thinking on/off             |
| `"ultrathink"`           | Max effort for turn                |
| `Ctrl+O`                 | See thinking (verbose)             |
| `/effort`                | ○ low · ◐ med · ● high (NEW)       |

## Git Worktrees

| Item                  | Description                     |
| --------------------- | ------------------------------- |
| `--worktree name`     | Isolated branch per feature     |
| `isolation: worktree` | Agent in own worktree           |
| `sparsePaths`         | Checkout only needed dirs (NEW) |
| `/batch`              | Auto-creates worktrees          |

## Voice Mode

| Item           | Description             |
| -------------- | ----------------------- |
| `/voice`       | Enable push-to-talk     |
| `Space` (hold) | Record, release to send |
| 20 languages   | EN, ES, FR, DE, CZ, PL… |

## Context Management

| Item                    | Description                    |
| ----------------------- | ------------------------------ |
| `/context`              | Usage + optimization tips      |
| `/compact [focus]`      | Compress with focus            |
| Auto-compact            | Triggers at ~95% capacity      |
| 1M context              | Opus 4.6 (Max/Team/Ent)        |
| `CLAUDE.md`             | Survives compaction            |
| `claude -c`             | Continue last conversation     |
| `claude -r "name"`      | Resume by name                 |
| `/btw question`         | Side question, no context cost |
| `claude -p "query"`     | Non-interactive                |
| `--output-format json`  | Structured output              |
| `--max-budget-usd 5`    | Cost cap                       |
| `cat file \| claude -p` | Pipe input                     |
| `/loop 5m msg`          | Recurring task                 |
| `/rc`                   | Remote control                 |
| `--remote`              | Web session on claude.ai       |

## Config Files

| File                          | Purpose             |
| ----------------------------- | ------------------- |
| `~/.claude/settings.json`     | User settings       |
| `.claude/settings.json`       | Project (shared)    |
| `.claude/settings.local.json` | Local only          |
| `~/.claude.json`              | OAuth, MCP, state   |
| `.mcp.json`                   | Project MCP servers |

### Key Settings

| Setting                | Description                   |
| ---------------------- | ----------------------------- |
| `modelOverrides`       | Map model picker → custom IDs |
| `autoMemoryDirectory`  | Custom memory dir             |
| `worktree.sparsePaths` | Sparse checkout dirs (NEW)    |

### Environment Variables

[Full reference](https://code.claude.com/docs/en/env-vars) — ~80+ variables. Most useful ones:

**Core / Auth**

| Variable                        | Description                               |
| ------------------------------- | ----------------------------------------- |
| `ANTHROPIC_API_KEY`             | API key (overrides subscription when set) |
| `ANTHROPIC_AUTH_TOKEN`          | Custom `Authorization` header value       |
| `ANTHROPIC_BASE_URL`            | Proxy/gateway endpoint                    |
| `ANTHROPIC_MODEL`               | Default model                             |
| `ANTHROPIC_CUSTOM_MODEL_OPTION` | Custom `/model` picker entry              |

**Cloud Providers**

| Variable                  | Description           |
| ------------------------- | --------------------- |
| `CLAUDE_CODE_USE_BEDROCK` | Use Amazon Bedrock    |
| `CLAUDE_CODE_USE_VERTEX`  | Use Google Vertex AI  |
| `CLAUDE_CODE_USE_FOUNDRY` | Use Microsoft Foundry |

**Model / Thinking**

| Variable                                | Description                              |
| --------------------------------------- | ---------------------------------------- |
| `CLAUDE_CODE_EFFORT_LEVEL`              | low/med/high/max/auto                    |
| `MAX_THINKING_TOKENS`                   | 0 = off                                  |
| `CLAUDE_CODE_SUBAGENT_MODEL`            | Override model for subagents             |
| `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING` | =1 to fall back to fixed thinking budget |

**Context / Behavior**

| Variable                          | Description                                                      |
| --------------------------------- | ---------------------------------------------------------------- |
| `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` | Auto-compact threshold (1–100, default ~95)                      |
| `CLAUDE_CODE_AUTO_COMPACT_WINDOW` | Override context window size for compaction                      |
| `BASH_DEFAULT_TIMEOUT_MS`         | Default bash command timeout                                     |
| `CLAUDE_CODE_SHELL`               | Override shell detection (bash/zsh)                              |
| `CLAUDE_ENV_FILE`                 | Script sourced before each bash command (virtualenv persistence) |
| `CLAUDE_CODE_PLUGIN_SEED_DIR`     | Plugin seed dirs (`:` separated)                                 |

**Privacy / Enterprise**

| Variable                                   | Description                                            |
| ------------------------------------------ | ------------------------------------------------------ |
| `DISABLE_TELEMETRY`                        | =1 to opt out of Statsig telemetry                     |
| `DISABLE_AUTOUPDATER`                      | =1 to disable auto-updates                             |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` | Disables telemetry, updates, error reporting, feedback |
| `CLAUDE_CODE_DISABLE_AUTO_MEMORY`          | =1 to disable auto memory                              |

**Runtime Detection**

| Variable     | Description                                                                      |
| ------------ | -------------------------------------------------------------------------------- |
| `CLAUDECODE` | =1 in CC-spawned shells                                                          |
| `IS_DEMO`    | Demo mode (hide email/org)                                                       |
| `IS_SANDBOX` | =1 to allow running as root (needed for `--dangerously-skip-permissions` in VMs) |

## Skills

### Built-in Skills

| Command            | Description                             |
| ------------------ | --------------------------------------- |
| `/simplify`        | Code review (3 parallel agents)         |
| `/batch`           | Large parallel changes (5–30 worktrees) |
| `/debug [desc]`    | Troubleshoot from debug log             |
| `/loop [interval]` | Recurring scheduled task                |
| `/claude-api`      | Load API + SDK reference                |

### Skill Locations

| Path                       | Scope           |
| -------------------------- | --------------- |
| `.claude/skills/<name>/`   | Project skills  |
| `~/.claude/skills/<name>/` | Personal skills |

### Skill Frontmatter

| Field                 | Description                 |
| --------------------- | --------------------------- |
| `description`         | Auto-invocation trigger     |
| `allowed-tools`       | Skip permission prompts     |
| `model`               | Override model for skill    |
| `effort`              | Override effort level (NEW) |
| `context: fork`       | Run in subagent             |
| `$ARGUMENTS`          | User input placeholder      |
| `${CLAUDE_SKILL_DIR}` | Skill's own directory       |
| `` !`cmd` ``          | Dynamic context injection   |

## Agents

### Built-in Agents

| Agent   | Description                |
| ------- | -------------------------- |
| Explore | Fast read-only (Haiku)     |
| Plan    | Research for plan mode     |
| General | Full tools, complex tasks  |
| Bash    | Terminal, separate context |

### Agent Frontmatter

| Field                   | Description                             |
| ----------------------- | --------------------------------------- |
| `permissionMode`        | default/acceptEdits/plan/dontAsk/bypass |
| `isolation: worktree`   | Run in git worktree                     |
| `memory: user\|project` | Persistent memory                       |
| `background: true`      | Background task                         |
| `maxTurns`              | Limit agentic turns                     |
| `SendMessage`           | Resume agents (replaces resume) (NEW)   |

## CLI Reference

### Core Commands

| Command         | Action        |
| --------------- | ------------- |
| `claude`        | Interactive   |
| `claude "q"`    | With prompt   |
| `claude -p "q"` | Headless      |
| `claude -c`     | Continue last |
| `claude -r "n"` | Resume        |
| `claude update` | Update        |

### Key Flags

| Flag                             | Description                           |
| -------------------------------- | ------------------------------------- |
| `--model`                        | Set model                             |
| `-w`                             | Git worktree                          |
| `-n` / `--name`                  | Session name                          |
| `--add-dir`                      | Add dir                               |
| `--agent`                        | Use agent                             |
| `--allowedTools`                 | Pre-approve                           |
| `--output-format`                | json/stream                           |
| `--json-schema`                  | Structured                            |
| `--max-turns`                    | Limit turns                           |
| `--max-budget-usd`               | Cost cap                              |
| `--console`                      | Auth via Anthropic Console            |
| `--verbose`                      | Verbose                               |
| `--bare`                         | Minimal headless (no hooks/LSP) (NEW) |
| `--channels`                     | Permission relay / MCP push (NEW)     |
| `--remote`                       | Web session                           |
| `--effort`                       | low/med/high/max                      |
| `--permission-mode`              | plan/default/…                        |
| `--dangerously-skip-permissions` | Skip all prompts ⚠️                   |
| `--chrome`                       | Chrome                                |
