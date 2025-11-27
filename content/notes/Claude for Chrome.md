---
created: 2025-11-26
tags:
  - Blogmarks
---

From [Piloting Claude for Chrome \| Claude](https://www.claude.com/blog/claude-for-chrome)

Prompt injection is a major risk since they are just a HUGE surface of attack possible:

> hide instructions in websites, emails, or documents to trick AIs into harmful actions without users' knowledge (like hidden text saying "disregard previous instructions and do {malicious action} instead").

The mitigations are on 3 layers

1. Browser permissions

> Users maintain control over what Claude for Chrome can access and do:
>
> - **Site-level permissions**: Users can grant or revoke Claude's access to specific websites at any time in the Settings.
> - **Action confirmations**: Claude asks users before taking high-risk actions like publishing, purchasing, or sharing personal data. Even when users opt into our experimental “autonomous mode,” Claude still maintains certain safeguards for highly sensitive actions (Note: all red-teaming and safety evaluations were conducted in autonomous mode).

2. System prompts

> ...we’ve improved our system prompts—the general instructions Claude receives before specific instructions from users—to direct Claude on how to handle sensitive data and respond to requests to take sensitive actions.

3. Block list

> ...we’ve blocked Claude from using websites from certain high-risk categories such as financial services, adult content, and pirated content.

4. ... and more ML

> And we’ve begun to build and test advanced classifiers to detect suspicious instruction patterns and unusual data access requests—even when they arise in seemingly legitimate contexts.
