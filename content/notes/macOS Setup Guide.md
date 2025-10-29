---
title: "macOS Setup Guide"
date: 2025-10-28
---

This page keeps track of the tips and tricks about macOS that I collect from the Internet.

## Improve Finder

Here are a few commands to improve the Finder experience. These are from [My Minimal MacBook Pro Setup Guide](https://eugeneyan.com/writing/mac-setup/).

```bash
# show Library folder
chflags nohidden ~/Library

# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# add pathbar to title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# restart finder
killall Finder;
```

## Using LLM CLIs

To use language model CLIs, you first need to set up your Node.js environment. I recommend using `nvm` (Node Version Manager) to manage Node.js versions.

1.  **Install nvm:** Follow the instructions on the [nvm GitHub page](https://github.com/nvm-sh/nvm).
2.  **Configure nvm for automatic version switching:** To automatically switch to the correct Node.js version for a project, you can create a `.nvmrc` file in your project's root directory. You can find more details in the [nvm documentation](httpss://github.com/nvm-sh/nvm#nvmrc).
3.  **Install LLM CLIs:** Once `nvm` is set up, you can install your favorite LLM CLIs. For example, to use the LTS version of Node.js and install some popular CLIs, you can do the following:

```bash
# Create a .nvmrc file to use the LTS version
echo "lts/*" > .nvmrc

# Install the CLIs globally
npm install -g @openai/codex @google/gemini-cli @anthropic-ai/claude-code
```
