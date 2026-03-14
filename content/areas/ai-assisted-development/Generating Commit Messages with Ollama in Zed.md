---
created: 2026-03-13
---

It took some digging to figure out how to generate commit messages with a local model in Zed — the UX isn't very clear. But the steps are actually quite simple once you find the right doc to read.

## Configuration

In `settings.json`, under `assistant`, you can specify `commit_message_model` ([docs](https://zed.dev/docs/git?highlight=generate%20commit%20message#ai-support-in-git)). I want to use a local model since commit messages aren't complicated and I don't really bother writing them most of the time while working on my knowledge base:

```json
"commit_message_model": {
  "provider": "ollama",
  "model": "qwen3.5:9b"
},
```

## Tweaking the prompt

There's also a way to tweak the prompt, but it also takes a bit to find. It's under the Rules library ([docs](https://zed.dev/docs/ai/rules#opening-the-rules-library)):

1. Open the Agent Panel.
2. Click the Agent menu (`...`) in the top right corner.
3. Select **Rules...** from the dropdown.

There should be a built-in rule called **"Commit message"** you can edit.
