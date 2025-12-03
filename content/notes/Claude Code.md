---
created: 2025-11-24
draft: "true"
---
[Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)


From [Prompting best practices - Claude Docs](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices#context-awareness-and-multi-window-workflows)

> If you are using Claude in an agent harness that compacts context or allows saving context to external files (like in Claude Code), we suggest adding this information to your prompt so Claude can behave accordingly. Otherwise, Claude may sometimes naturally try to wrap up work as it approaches the context limit. Below is an example prompt:
>
> ```
> Your context window will be automatically compacted as it approaches its limit, allowing you to continue working indefinitely from where you left off. Therefore, do not stop tasks early due to token budget concerns. As you approach your token budget limit, save your current progress and state to memory before the context window refreshes. Always be as persistent and autonomous as possible and complete tasks fully, even if the end of your budget is approaching. Never artificially stop any task early regardless of the context remaining.
> ```


[Manage Claude's memory - Claude Code Docs](https://code.claude.com/docs/en/memory#how-claude-looks-up-memories)

```json
{
  "permissions": {
    "allow": [
      "*",
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Glob",
      "Grep",
      "Task",
      "TodoWrite",
      "WebFetch",
      "WebSearch",
      "NotebookEdit",
      "NotebookRead",
      "AskUserQuestion",
      "Skill",
      "SlashCommand",
      "BashOutput",
      "KillShell",
      "mcp__playwright__*",
      "mcp__chrome-devtools__*"
    ],
    "deny": [],
    "ask": [
      "Bash(git commit:*)",
      "Bash(git push:*)",
      "Bash(rm:*)"
    ],
    "defaultMode": "acceptEdits"
  }
}
```