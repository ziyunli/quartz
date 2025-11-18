---
created: 2025-11-17
---
Early this year I got an Apple M4 Pro (64 GB) as my home lab to tinker with AI. It's not the most powerful machine for sure, but it has enough to try out some reasonably large LLMs locally, easier to share configs with my other Apple laptops (work + personal), and small enough that I can just put it at a corner of my working desk and forget about it.

This document is going to be a "live journal" on my setup, mainly as a note to the future me, and also hopefully provide some inspirations to others.

## Basic Sysadmin Stuff

### Enable SSH

```sh
sudo systemsetup -setremotelogin on
```

### Install Tailscale

Install [Tailscale](https://tailscale.com/) on Mac Mini and also other devices you want to connect to it. Then on your "client" devices:

```sh
ssh-copy-id user@my-mac-mini # so that you don't have to try typing password
ssh user@my-mac-mini # from your laptop
mosh user@my-mac-mini # from your phone
```

## LLM

### Cloud-based LLM CLIs

To use cloud-based LLM CLIs, you first need to set up your Node.js environment. I recommend using `nvm` (Node Version Manager) to manage Node.js versions.

1.  **Install nvm:** Follow the instructions on the [nvm GitHub page](https://github.com/nvm-sh/nvm).
2.  **Configure nvm for automatic version switching:** To automatically switch to the correct Node.js version for a project, you can create a `.nvmrc` file in your project's root directory. You can find more details in the [nvm documentation](https://github.com/nvm-sh/nvm#nvmrc).
3.  **Install LLM CLIs:** Once `nvm` is set up, you can install your favorite LLM CLIs. For example, to use the LTS version of Node.js and install some popular CLIs, you can do the following:

```bash
# Create a .nvmrc file to use the LTS version
echo "lts/*" > .nvmrc

# Install the CLIs globally
npm install -g @openai/codex @google/gemini-cli @anthropic-ai/claude-code
```

### Simon Willison's llm CLI

```sh
# Install llm via UV
uv tool install llm
# Install hackner news plugin
llm install llm-hacker-news
# set API key for uvx?
uv tool run llm keys set openai # ~/Library/Application\ Support/io.datasette.llm/keys.json

# Example
uv tool run llm -f hn:43984860 'summary with illustrative direct quotes'
```

### Local LLM

#### Ollama

```sh
ollama pull deepseek-r1:32b

uv tool install open-webui
uv tool run open-webui serve
```

#### Qwen3 using MLX

[Running Qwen3 on your macbook, using MLX, to vibe code for free](https://localforge.dev/blog/running-qwen3-macbook-mlx)

Besides setup process for Localforge, it's essentially serving the model via `mlx-lm`:

```shell
mlx_lm.server --model mlx-community/Qwen3-30B-A3B-8bit --trust-remote-code --port 8082
```

We can combine the tip from the [simonw's HN comment](https://news.ycombinator.com/item?id=43822763) and [a fix to force Python 3.12](https://news.ycombinator.com/item?id=43824980):


```shell
uv run --isolated -p 3.12 --with mlx-lm mlx_lm.server --model mlx-community/Qwen3-30B-A3B-8bit --trust-remote-code --port 8082
```

## Speech to Text

From [parakeet-mlx](https://simonwillison.net/2025/November/14/parakeet-mlx/#atom-everything)

```shell
uvx parakeet-mlx default_tc.mp3
```

---

*Edited by Claude (claude-sonnet-4-5-20250929)*
