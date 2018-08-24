#!/bin/bash

precision=0
percentage=$(echo $(xbacklight -get) | xargs printf "%.*f\n" $precision)

if [ "$percentage" -ge 80 -a "$percentage" -le 100 ]; then
	xbacklight -set 10
elif [ "$percentage" -ge 10 -a "$percentage" -le 20 ]; then
	xbacklight -set 30
elif [ "$percentage" -ge 20 -a "$percentage" -le 40 ]; then
	xbacklight -set 50
elif [ "$percentage" -ge 40 -a "$percentage" -le 60 ]; then
	xbacklight -set 70
else
	xbacklight -set 90
fi

exit 0
