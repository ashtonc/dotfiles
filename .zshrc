# Prompt
PROMPT='%~ %B|%b '
EDITOR='vim'
VISUAL=$EDITOR
PAGER='less'

# History
# Set screen brightness keys
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000
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

# Config scripts
PATH=$PATH:~/.config/bin

# Aliases
## Backlight
alias light='xbacklight'

## Volume
alias vol='pulseaudio-ctl'

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
alias tree1='exa -T -L 1'
alias tree2='exa -T -L 2'

## changing programs
alias top='htop'

# tmux

alias tmux-session='cd ~; tmux new-session -n home \; split-window -h \; new-window -c "projects/anki-decks" -n "anki" \; split-window -h -c "projects/anki-decks" \; new-window -c "applications" -n "applications" \; split-window -h -c "applications" \; move-window -s 3 -t 9 \; move-window -s 2 -t 8 \; select-window -t 1 \; select-pane -t 1'

# Gcloud

## The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

## The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Fix delete/home/end/insert/pgup/pgdown keys
bindkey "^[[5~" beginning-of-line
bindkey "^[[6~" end-of-line
bindkey "^[[1~" beginning-of-history
bindkey "^[[4~" end-of-history
bindkey "^[[7~" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[2~" quoted-insert

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ashton/google-cloud-sdk/path.zsh.inc' ]; then source '/home/ashton/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ashton/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/ashton/google-cloud-sdk/completion.zsh.inc'; fi

source ~/.config/private-aliases
