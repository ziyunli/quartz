---
draft: true
---

## Preparing a VPS

### Security

```sh
ssh-copy-id -i ~/.ssh/id_ed25519 root@your-server-ip
ssh root@your-server-ip
apt update && apt upgrade -y

uname -a
cat /etc/os-release

# Change root password
passwd

# Create user
adduser your-username
usermod -aG sudo your-username
groups your-username
su - your-username
sudo whoami

ssh-copy-id -i ~/.ssh/id_ed25519 your-username @your-server-ip

# Tailscale
curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up --auth-key=some-key

sudo ufw status
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow in on tailscale0

sudo ufw reload
sudo service ssh restart

sudo ufw enable
sudo ufw status verbose
```

### Tools

```sh
# Node
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Codex + Gemini
npm install -g @openai/codex @google/gemini-cli

# Moltbot
curl -fsSL https://molt.bot/install.sh | bash

# Native build of Claude takes a bit memory
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# gh CLI
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

sudo apt update
sudo apt install gh

sudo apt install tig lazygit
```

### Dotfiles

Add dotfiles function

```
dotfiles() {
  GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME "$@"
}
```

```sh
git clone --bare git@github.com:ziyunli/dotfiles.git $HOME/.dotfiles
dotfiles git config --local status.showUntrackedFiles no
```

### Journal

```sh
claude mcp add-json private-journal '{"type":"stdio","command":"npx","args":["github:obra/private-journal-mcp"]}' -s user
```

### Reference

[VPS Setup and Security Checklist](https://bhargav.dev/blog/VPS_Setup_and_Security_Checklist_A_Complete_Self_Hosting_Guide)
