## Me

Ashton Charbonneau
ashton@ashtonc.ca

Dotfiles are for a Lenovo T470 (20HD)

## Setup

This is my dotfiles repository. It is set up similarly to the comment and article:
- https://news.ycombinator.com/item?id=11071754
- https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

    git init --bare $HOME/.cfg
    alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    cfg config status.showUntrackedFiles no

## Programs

- window management
	- xmonad
	- xmobar
	- rofi
- terminal
	- alacritty
	- tmux
	- zsh
- media
	- mpv
	- feh
	- zathura
	- ranger
- editor
	- vim
	- emacs

## To do

- control
	- libinput gestures
	- think of better remaps for the keyboard thing at F11 and tools at F9
- xmonad
	- xmobar weather location change script
	- dynamic workspaces?
	- more (fewer?) layouts
	- xmonad scratchpad? (maybe)
- tmux
	- tmux design changes
	- tmux color scheme
- rofi
	- wifi menu
	- power menu
- scripts
	- script so that i can charge my battery to 100% once
	- color scheme script to prevent duplicate entries
- design
	- vim color scheme fix
	- wallpaper? maybe
	- zsh prompt git repo integration
	- minor xterm config (backup for alacritty)
- buy pragmatapro
- better org mode integrations
- learn to use ranger
- see if xresources is useful for anything with my setup

