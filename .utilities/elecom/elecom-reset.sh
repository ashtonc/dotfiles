#!/bin/bash
# Remaps the buttons on my ELECOM Huge

SEARCH="ELECOM TrackBall Mouse HUGE TrackBall"

if [ "$SEARCH" = "" ]; then 
    exit 1
fi

ids=$(xinput --list | awk -v search="$SEARCH" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

for i in $ids
do
	xinput disable $i
	xinput enable $i
	xinput set-button-map $i 1 2 3 4 5 6 7 8 9 2 11 1
done

