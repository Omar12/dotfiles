# Omar's dotfiles

Zsh (oh-my-zsh) dotfiles for macOS on Apple Silicon, based on
[Mathias Bynens’s dotfiles](https://github.com/mathiasbynens/dotfiles). Bash is
supported but secondary.

## Installation

### Prerequisites

Install [Homebrew](https://brew.sh) and oh-my-zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

`.zshrc` also expects these zsh add-ons:

* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) as an oh-my-zsh custom plugin
* [zsh-histdb](https://github.com/larkery/zsh-histdb)

### Using Git and the bootstrap script

Clone the repository anywhere (I keep it in `~/projects/dotfiles`). The bootstrap
script rsyncs the files into your home folder:

```bash
git clone https://github.com/omar12/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `git pull` in your local repository, then run `source bootstrap.sh`
again (`source bootstrap.sh -f` skips the confirmation prompt).

Editing a file in the repo does not affect your shell until you re-run
`bootstrap.sh`; shells read the copies in `~`.

### Git-free install

```bash
cd; curl -#L https://github.com/omar12/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE-MIT.txt,.osx}
```

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-26)) takes place.

Here’s an example `~/.path` file that adds `~/utils` to the `$PATH`:

```bash
export PATH="$HOME/utils:$PATH"
```

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Omar Martinez"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="you@example.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

You can also use `~/.extra` to override settings, functions and aliases.

**Secrets live in `~/.extra` only.** API keys and tokens must never go in `.exports`,
`.zshrc` or `.functions` — those are tracked. `~/.extra` is absent from this repo, so
`bootstrap.sh` never overwrites it and git never sees it.

### Install Homebrew packages

`Brewfile` is a snapshot of the installed formulae, casks and taps
(regenerate it with `brew bundle dump --force`):

```bash
brew bundle
```

### Global npm packages

Node is managed by nvm, so install globals after `nvm install`:

```bash
source npm.sh
```

### macOS defaults

`.osx` sets macOS defaults (audited for macOS 15 Sequoia on Apple Silicon) and
restarts Finder and the Dock. Run it with `bash`, not `source`. Give your terminal
Full Disk Access first, or the Safari settings fail:

```bash
bash .osx
```

## Feedback

Suggestions/improvements
[welcome](https://github.com/omar12/dotfiles/issues)!

## Thanks to…

* [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles), which this is based on
* @ptb and [his _OS X Lion Setup_ repository](https://github.com/ptb/Mac-OS-X-Lion-Setup)
* [Ben Alman](http://benalman.com/) and his [dotfiles repository](https://github.com/cowboy/dotfiles)
* [Chris Gerke](http://www.randomsquared.com/) and his [tutorial on creating an OS X SOE master image](http://chris-gerke.blogspot.com/2012/04/mac-osx-soe-master-image-day-7.html) + [_Insta_ repository](https://github.com/cgerke/Insta)
* [Cãtãlin Mariş](https://github.com/alrra) and his [dotfiles repository](https://github.com/alrra/dotfiles)
* [Gianni Chiappetta](http://gf3.ca/) for sharing his [amazing collection of dotfiles](https://github.com/gf3/dotfiles)
* [Jan Moesen](http://jan.moesen.nu/) and his [ancient `.bash_profile`](https://gist.github.com/1156154) + [shiny _tilde_ repository](https://github.com/janmoesen/tilde)
* [Lauri ‘Lri’ Ranta](http://lri.me/) for sharing [loads of hidden preferences](http://osxnotes.net/defaults.html)
* [Matijs Brinkhuis](http://hotfusion.nl/) and his [dotfiles repository](https://github.com/matijs/dotfiles)
* [Nicolas Gallagher](http://nicolasgallagher.com/) and his [dotfiles repository](https://github.com/necolas/dotfiles)
* [Sindre Sorhus](http://sindresorhus.com/)
* [Tom Ryder](http://blog.sanctum.geek.nz/) and his [dotfiles repository](https://github.com/tejr/dotfiles)
* [Kevin Suttle](http://kevinsuttle.com/) and his [dotfiles repository](https://github.com/kevinSuttle/dotfiles) and [OSXDefaults project](https://github.com/kevinSuttle/OSXDefaults), which aims to provide better documentation for [`~/.osx`](http://mths.be/osx)

* anyone who [contributed a patch](https://github.com/mathiasbynens/dotfiles/contributors) or [made a helpful suggestion](https://github.com/mathiasbynens/dotfiles/issues)
