# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify

# Disable beeping
unsetopt beep

# ?
bindkey -v

# Advanced command completion
autoload -Uz compinit
compinit

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases

## dotfiles
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

## rebindings with arguments
alias ls='ls -a  --color=auto'
alias mkdir='mkdir -pv'

## typos and ease of use
alias cd..='cd ..'
alias ..='cd ..'
alias .='source ~/.zshrc'

## changing programs
alias top='htop'

