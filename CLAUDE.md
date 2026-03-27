# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal shell dotfiles based on [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles). Configures Bash/Zsh environments primarily for macOS.

## Installation

```bash
# Install dotfiles (rsyncs to ~/)
source bootstrap.sh

# Force install without confirmation
source bootstrap.sh -f

# Install Homebrew packages
source brew.sh

# Install global npm packages
source npm.sh

# Apply macOS system defaults (macOS only)
source .osx
```

## Architecture

### Modular Shell Config (loaded by `.bash_profile`)
- `.path` — custom PATH entries (not in repo; user-created)
- `.exports` — environment variables
- `.aliases` — 170+ command shortcuts
- `.functions` — utility functions
- `.bash_prompt` — git-aware prompt
- `.extra` — private/local overrides (not in repo; recommended for git credentials)

### Extensibility Pattern
Private customizations go in `~/.path` and `~/.extra` (gitignored by design). Example `.extra`:
```bash
GIT_AUTHOR_NAME="Your Name"
git config --global user.name "$GIT_AUTHOR_NAME"
```

### Shell Startup Flow
`.bash_profile` → loads all modular configs → auto-starts Zsh → `.zshrc` sources `.bash_profile`

### Key Files
- `bootstrap.sh` — rsync-based installer; excludes `.git/`, `.osx`, `README.md`, `LICENSE`
- `brew.sh` — Homebrew formula/cask installer
- `.gitconfig` — git aliases (`l`, `st`, `d`, `ca`, `go`, `dm`, `ph`, `reb`, etc.)
- `.vimrc` — Vim with Molokai theme, 2-space tabs, centralized backups
- `iterm.json` — iTerm2 profile import
- `manual_installations.md` — zsh plugins requiring manual setup (e.g. zsh-histdb)
