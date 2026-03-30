# ── PATH ──────────────────────────────────────────────────────────────────────
# Consolidate all PATH additions in one place for clarity.
# Individual tool paths are also added later where they are initialized.
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# npm global packages (prefix set in .npmrc)
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH  # inherit from /etc/manpath via the `manpath` command
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"

# ── nvm ───────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ── Dotfile modules ───────────────────────────────────────────────────────────
# Load in order: .path (custom PATH), .bash_prompt, .exports, .aliases, .functions
# .extra is for private settings that should not be committed (e.g. git credentials)
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# ── Bash options ──────────────────────────────────────────────────────────────
shopt -s nocaseglob   # case-insensitive globbing in pathname expansion
shopt -s histappend   # append to history file instead of overwriting
shopt -s cdspell      # autocorrect typos in path names when using `cd`

# Bash 4 features (silently skip on older versions)
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# ── Tab completion ─────────────────────────────────────────────────────────────
# SSH hostnames from ~/.ssh/config (ignore wildcards)
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# `defaults read|write NSGlobalDomain` — prefer explicit over `-g`
complete -W "NSGlobalDomain" defaults

# Common apps for `killall` tab completion
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari SystemUIServer Terminal" killall

# System-wide bash completion (if available)
[ -f /etc/bash_completion ] && source /etc/bash_completion

# ── Prompt ────────────────────────────────────────────────────────────────────
export PS1="\W ✨  "

# ── Marks: quick filesystem navigation ────────────────────────────────────────
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
export MARKPATH="$HOME/.marks"

function jump {
	cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
	mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
	rm -i "$MARKPATH/$1"
}
function marks {
	\ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}

_completemarks() {
	local curw=${COMP_WORDS[COMP_CWORD]}
	local wordlist=$(find $MARKPATH -type l -printf "%f\n")
	COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
	return 0
}
complete -F _completemarks jump unmark

# ── fzf ───────────────────────────────────────────────────────────────────────
# Ctrl+O opens the fzf-selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# ── bash-git-prompt ───────────────────────────────────────────────────────────
# https://github.com/magicmonty/bash-git-prompt — shows git status in prompt
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
	__GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
	GIT_PROMPT_ONLY_IN_REPO=1
	source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# ── RVM ───────────────────────────────────────────────────────────────────────
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# ── Start Zsh ─────────────────────────────────────────────────────────────────
# Launch Zsh when Bash is the login shell (e.g. on macOS default terminal)
export SHELL="$(which zsh)"
[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
