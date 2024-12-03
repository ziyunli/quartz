This page keeps track of the tips and tricks about macOS that I collect from Internet.

[My Minimal MacBook Pro Setup Guide](https://eugeneyan.com/writing/mac-setup/)

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
