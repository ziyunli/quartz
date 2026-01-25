---
tags:
  - Blogmarks
draft: false
---

From [X](https://x.com/bcherny/status/2007179832300581177):

1. Many (1-5) sessions in different tabs, with system notifications ([Optimize your terminal setup - Claude Code Docs](https://code.claude.com/docs/en/terminal-config#notification-setup))
   1. [claude_ghostty_notification_setup.md · GitHub](https://gist.github.com/bestdan/ffa396de6ac032fa9edd54971706a00b)
2. 5-10 session in the cloud [Claude Code on the Web](https://claude.ai/code) 3. [send tasks from your terminal to run on the web](https://code.claude.com/docs/en/claude-code-on-the-web#from-terminal-to-web) with the `&` prefix 4. [teleport web sessions back to your terminal](https://code.claude.com/docs/en/claude-code-on-the-web#from-web-to-terminal) to continue locally.
3. Use Opus 4.5 (or I guess in general frontier models)
4. [Claude Code GitHub Actions](https://code.claude.com/docs/en/github-actions) to edit Claude.md during code review (i.e. Compounding Engineering)
5. > Most sessions start in Plan mode (shift+tab twice). If my goal is to write a Pull Request, I will use Plan mode, and go back and forth with Claude until I like its plan. From there, I switch into auto-accept edits mode and Claude can usually 1-shot it. A good plan is really important!
6. Slash commands for repeated prompting
   1. Note that **Custom slash commands have been merged into skills.**[^1]
7. > I use a few subagents regularly: code-simplifier simplifies the code after Claude is done working, verify-app has detailed instructions for testing Claude Code end to end, and so on.[^2]
8. Use a PostToolUse[^3] hook to format Claude's code
9. Use /permissions to pre-allow common bash commands, and check into `.claude/settings.json`
10. Using Tools
    1. Slack via MCP (MCP configuration is checked into our `.mcp.json`)
    2. BigQuery using bq CLI
11. > For very long-running tasks, I will either (a) prompt Claude to verify its work with a background agent when it's done, (b) use an agent Stop hook to do that more deterministically, or (c) use the ralph-wiggum[^4] plugin. I will also use either `--permission-mode=dontAsk` or `--dangerously-skip-permissions` in a sandbox to avoid permission prompts for the session, so Claude can cook without being blocked on me.
12. Give Claude a way to verify its work
    1. Claude Chrome extension: It opens a browser, tests the UI, and iterates until the code works and the UX feels good.

[^1]: [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/slash-commands#bash-command-execution)

[^2]: [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

[^3]: [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks#posttooluse)

[^4]: [ralph-loop](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/ralph-loop)
