# History
# Set screen brightness keys
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify

# Disable beeping
unsetopt beep

# Change the line editor to emacs mode
bindkey -e

# Advanced command completion
autoload -Uz compinit
compinit

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt
autoload -Uz promptinit
promptinit

# Cabal
PATH=$PATH:~/.cabal/bin

# Aliases
## Backlight
alias light='xbacklight'

## Volume
alias vol='pulseaudio-ctl'

## Google cloud projects
alias gdata='gcloud config set project ashtonc-data'
alias ghome='gcloud config set project ashtonc-home'

## dotfiles
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

## rebindings with arguments
alias ls='exa'
alias mkdir='mkdir -pv'

## typos and ease of use
alias cd..='cd ..'
alias ..='cd ..'
alias .='source ~/.zshrc'
alias tree='exa -T'
alias tre='exa -T'
alias tee='exa -T'

## changing programs
alias top='htop'

# Gcloud

## The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

## The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

# fzf

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

