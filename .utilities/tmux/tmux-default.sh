#!/bin/bash

tmux attach-session -t "default" || \
tmux new-session -n "home" -s "default" \; \
    split-window -h -c "/home/ashton/" \; \
    new-window -c "/home/ashton/" -n "study" \; \
    split-window -h -c "/home/ashton/" \; \
    new-window -c "/home/ashton/website-manager/" -n "web" \; \
    split-window -h -c "/home/ashton/website-manager/" \; \
    new-window -c "/home/ashton/projects/anki-decks/" -n "anki" \; \
    split-window -h -c "/home/ashton/projects/anki-decks/" \; \
    move-window -s 2 -t 9 \; \
    move-window -s 3 -t 8 \; \
    move-window -s 4 -t 7 \; \
    select-window -t 1 \; \
    select-pane -t 1

