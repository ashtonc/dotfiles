# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/ashton/.zshrc'

autoload -Uz compinit
compinit

# zsh syntax highlighting
source
/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
