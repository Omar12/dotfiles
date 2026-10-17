# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal shell dotfiles based on [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles). Zsh (oh-my-zsh) is the login shell; Bash is supported but secondary. macOS, Apple Silicon. No build, no tests, no lint.

## Commands

```bash
source bootstrap.sh       # rsync repo files into ~ (prompts first)
source bootstrap.sh -f    # no prompt
brew bundle               # install everything in Brewfile
brew bundle dump --force  # regenerate Brewfile from what's installed
source npm.sh             # global npm packages
bash .osx                 # macOS defaults (restarts Finder/Dock); never `source` it
```

Verifying a change: no test suite. `bash -n <file>` / `zsh -n <file>` for syntax, then `bash bootstrap.sh -f` and `zsh -i -c 'echo ok'` to confirm a clean interactive startup (it should print nothing but `ok`; warnings there are real regressions). Editing a file in the repo does **not** affect running shells — `bootstrap.sh` copies to `~` and those copies are what shells read.

## Architecture

### Load order

Both shells load the same modular files; neither sources the other.

- `~/.zshrc` — oh-my-zsh, then `~/.{path,exports,aliases,functions,extra}`, then `typeset -U path`, zsh-histdb, zoxide, fzf.
- `~/.bash_profile` — the same list plus `~/.bash_prompt`, then bash-only `shopt`/`complete` settings and bash-git-prompt.

Anything that must work in both shells goes in `.exports` / `.aliases` / `.functions`. Bash-only completions go in `.bash_profile`; zsh-only setup goes in `.zshrc`. `.bashrc` is one line delegating to `.bash_profile`.

Earlier versions had `.bash_profile` `exec`ing zsh while `.zshrc` sourced `.bash_profile` back; that loop is gone. Don't reintroduce cross-sourcing.

### Untracked by design

`~/.path` (machine-specific PATH) and `~/.extra` (git identity, secrets) are absent from the repo, so rsync never overwrites them.

### Secrets

**All API keys and tokens live in `~/.extra`, never in a tracked file.** `.exports`, `.zshrc` and `.functions` have each held a live credential in the past; functions read them from the environment instead (e.g. `myspotdl` uses `$SPOTDL_CLIENT_ID`). Git history is currently clean of real key values — keep it that way.

### bootstrap.sh

rsyncs everything except `.git/`, `.DS_Store`, `.osx`, `bootstrap.sh`, `README.md`, `LICENSE-MIT.txt`. So `Brewfile`, `npm.sh`, `iterm.json`, `CLAUDE.md` and `bin/` land in `~` too. A repo-only file needs a new `--exclude` in `doIt()`.

### Package installs

`Brewfile` (a `brew bundle dump` snapshot) replaced the old hand-maintained `brew.sh` and `.cask`, both of which had rotted into invalid syntax. Regenerate rather than hand-edit. Node globals are managed by nvm — `.npmrc` deliberately sets no `prefix`, since that conflicts with nvm.

### Other files

`.gitconfig` — aliases (`l`, `st`, `d`, `ca`, `go`, `dm`, `ph`, `reb`); identity is set from `~/.extra`, not here. `.vimrc` — Molokai, 2-space tabs, centralized backups. `iterm.json` — iTerm2 profile. `manual_installations.md` — zsh plugins needing manual setup (zsh-histdb).

### .osx

`.osx` was audited for macOS 15 Sequoia on Apple Silicon (Oct 2026). Must run under `bash`: sourcing it leaves the sudo keep-alive loop running in your shell.
