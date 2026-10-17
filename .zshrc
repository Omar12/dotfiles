# ── oh-my-zsh ─────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

# Plugins: git provides aliases, zsh-syntax-highlighting colorizes commands
# zsh-histdb must be installed manually (see manual_installations.md)
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ── Dotfile modules ───────────────────────────────────────────────────────────
# Same set ~/.bash_profile loads, minus the bash-only bits.
# ~/.path and ~/.extra are untracked (PATH additions, git identity, secrets).
for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Drop duplicate $PATH entries
typeset -U path PATH

# ── zsh-histdb ────────────────────────────────────────────────────────────────
HISTDB="$HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh"
[ -r "$HISTDB" ] && source "$HISTDB"
autoload -Uz add-zsh-hook

# ── zoxide / fzf ──────────────────────────────────────────────────────────────
command -v zoxide > /dev/null && eval "$(zoxide init zsh)"
command -v fzf > /dev/null && source <(fzf --zsh)

# ── Aliases ───────────────────────────────────────────────────────────────────
alias ec="$EDITOR $HOME/.zshrc"   # edit this file
alias sc="source $HOME/.zshrc"    # reload this file

# ── File associations (suffix aliases) ────────────────────────────────────────
# Typing a filename opens it in VS Code
alias -s md=code
alias -s json=code
alias -s {cs,ts,html,js}=code
