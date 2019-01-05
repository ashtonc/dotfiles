#!/bin/bash

precision=0
percentage=$(echo $(xbacklight -get) | xargs printf "%.*f\n" $precision)

if [ "$percentage" -gt 80 -a "$percentage" -le 100 ]; then
	xbacklight -set 10
elif [ "$percentage" -ge 0 -a "$percentage" -le 20 ]; then
	xbacklight -set 30
elif [ "$percentage" -gt 20 -a "$percentage" -le 40 ]; then
	xbacklight -set 50
elif [ "$percentage" -gt 40 -a "$percentage" -le 60 ]; then
	xbacklight -set 70
else
	xbacklight -set 90
fi

exit 0

