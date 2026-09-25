typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/Users/koks/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=500

export EDITOR=/opt/homebrew/bin/nvim
export VISUAL=/opt/homebrew/bin/nvim
export HOMEBREW_NO_ENV_HINTS=1
export LDFLAGS="-L/opt/homebrew/opt/openssl@3.3/lib"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3.3/include"
export CPPFLAGS="-I/opt/homebrew/Cellar/unixodbc/2.3.12/include:$CPPFLAGS" 
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib:$LDFLAGS"
export LDFLAGS="-L/opt/homebrew/Cellar/unixodbc/2.3.12/lib:$LDFLAGS"
export PATH="/opt/homebrew/opt/openssl@3.3/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/Users/koks/.local/bin:$PATH"
export PATH="$PATH:/Users/koks/.spoof-dpi/bin"

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

# rosetta terminal setup
#if [ $(arch) = "i386" ]; then
#    alias brew86="/usr/local/bin/brew"
#    alias pyenv86="arch -x86_64 pyenv"
#fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

## Alias section
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias vim='nvim'
alias vi='nvim'
alias upgrade='brew upgrade'
alias runserver='uv run --env-file=.env python manage.py runserver'
alias makemigrations='uv run --env-file=.env python manage.py makemigrations'
alias migrate='uv run --env-file=.env python manage.py migrate'
alias celeryworker='uv run --env-file=.env celery -A libs.celery worker --pool=threads'

# Print some system information when the shell is first started
# Print a greeting message when shell is started
# echo $USER@$HOST $(uname -srm) #$(lsb_release -rs)

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Use autosuggestion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/koks/.lmstudio/bin"


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/koks/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

export PYTHONIOENCODING=utf-8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# opencode
export PATH=/Users/koks/.opencode/bin:$PATH

# It must be in the end of .zshrc
# eval "$(starship init zsh)"
