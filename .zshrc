# ── oh-my-zsh ─────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

# Plugins: git provides aliases, zsh-syntax-highlighting colorizes commands
# zsh-histdb must be installed manually (see manual_installations.md)
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ── Dotfile modules ───────────────────────────────────────────────────────────
# Source shared shell config. Note: .bash_profile also sources these files, so
# they will be loaded again if zsh was launched from bash — that is harmless.
[ -r "$HOME/project/dotfiles/.aliases" ] && source "$HOME/project/dotfiles/.aliases"
[ -r "$HOME/project/dotfiles/.exports" ] && source "$HOME/project/dotfiles/.exports"

if [ -f ~/.bash_profile ]; then
	. ~/.bash_profile
fi

# ── zsh-histdb ────────────────────────────────────────────────────────────────
source $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh
autoload -Uz add-zsh-hook

# ── Aliases ───────────────────────────────────────────────────────────────────
alias ec="$EDITOR $HOME/.zshrc"   # edit this file
alias sc="source $HOME/.zshrc"    # reload this file

# ── File associations (suffix aliases) ────────────────────────────────────────
# Typing a filename opens it in VS Code
alias -s md=code
alias -s json=code
alias -s {cs,ts,html,js}=code
