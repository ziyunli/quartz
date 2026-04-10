---
created: 2026-04-05
---

Based on [~/.dotfiles/shared/.tmux.conf](https://github.com/ziyunli/dotfiles)

## Custom Bindings

**Prefix: `C-a`** (Ctrl+a)

### Config

| Keys      | Action                     |
| :-------- | :------------------------- |
| `C-a r`   | Reload tmux config         |
| `C-a C-a` | Send literal Ctrl-a to app |

### Pane Splitting

| Keys     | Action                            |
| :------- | :-------------------------------- |
| `C-a \|` | Split horizontally (side-by-side) |
| `C-a -`  | Split vertically (top/bottom)     |

### Pane Navigation (vim-style)

| Keys          | Action                  |
| :------------ | :---------------------- |
| `C-a h/j/k/l` | Move left/down/up/right |

### Pane Resizing (repeatable)

| Keys          | Action                         |
| :------------ | :----------------------------- |
| `C-a H/J/K/L` | Resize left/down/up/right by 5 |

### Window Navigation (repeatable)

| Keys      | Action          |
| :-------- | :-------------- |
| `C-a C-h` | Previous window |
| `C-a C-l` | Next window     |

### Fuzzy File Finder (no prefix)

| Keys                  | Action                                            |
| :-------------------- | :------------------------------------------------ |
| `Alt-p`               | Open fzf popup (80×80%, bat preview)              |
| `Ctrl-g` (inside fzf) | Switch to no-ignore mode (shows gitignored files) |
| `Ctrl-h` (inside fzf) | Switch back to normal mode                        |

---

## Default Bindings (Unchanged)

### Sessions

| Keys              | Action                             |
| :---------------- | :--------------------------------- |
| `C-a d`           | Detach from session                |
| `C-a s`           | List/switch sessions (interactive) |
| `C-a $`           | Rename current session             |
| `C-a (` / `C-a )` | Previous / next session            |

### Windows

| Keys                     | Action                             |
| :----------------------- | :--------------------------------- |
| `C-a c`                  | Create new window                  |
| `C-a &`                  | Kill current window (with confirm) |
| `C-a ,`                  | Rename current window              |
| `C-a w`                  | List/switch windows (interactive)  |
| `C-a 1-9`                | Jump to window by number           |
| `C-a p` / `C-a n`        | Previous / next window             |
| `C-a .`                  | Move window to a different number  |
| `:swap-window -s 2 -t 5` | Swap windows 2 and 5               |

### Pane Management

| Keys              | Action                                  |
| :---------------- | :-------------------------------------- |
| `C-a x`           | Kill current pane (with confirm)        |
| `C-a z`           | Toggle pane zoom (fullscreen)           |
| `C-a !`           | Break pane into its own window          |
| `C-a {` / `C-a }` | Swap pane with previous / next          |
| `C-a Space`       | Cycle through pane layouts              |
| `C-a o`           | Cycle to next pane                      |
| `C-a ;`           | Toggle to last active pane              |
| `C-a q`           | Show pane numbers (type number to jump) |

### Copy Mode (scroll/search)

| Keys      | Action                                |
| :-------- | :------------------------------------ |
| `C-a [`   | Enter copy mode (vi keys to navigate) |
| `q`       | Exit copy mode                        |
| `/` / `?` | Search forward / backward             |
| `Space`   | Start selection                       |
| `Enter`   | Copy selection and exit               |
| `C-a ]`   | Paste buffer                          |

---

## CLI Commands

| Command                     | Action                                             |
| :-------------------------- | :------------------------------------------------- |
| `tmux new -s name`          | New named session                                  |
| `tmux ls`                   | List sessions                                      |
| `tmux a -t name`            | Attach to named session                            |
| `tmux kill-session -t name` | Kill a session                                     |
| `tmux kill-server`          | Kill server (needed after `set-clipboard` changes) |

---

## Config Highlights

- **Mouse**: on
- **Base index**: 1 (windows and panes start at 1)
- **Escape time**: 1ms (no delay after prefix)
- **Clipboard**: OSC52 on (works over SSH)
- **Allow-passthrough**: on (tmux 3.3+)
- **Activity monitoring**: on
