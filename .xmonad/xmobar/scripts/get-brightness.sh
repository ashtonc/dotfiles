#!/bin/bash

precision=0
percentage=$(echo $(xbacklight -get) | xargs printf "%.*f\n" $precision)

if [ "$percentage" -ge 0 -a "$percentage" -le 10 ]; then
	echo "<fn=2></fn> $percentage%"
elif [ "$percentage" -ge 11 -a "$percentage" -le 20 ]; then
	echo "<fn=2></fn> $percentage%"
elif [ "$percentage" -ge 21 -a "$percentage" -le 30 ]; then
	echo "<fn=2></fn> $percentage%"
elif [ "$percentage" -ge 31 -a "$percentage" -le 40 ]; then
	echo "<fn=2></fn> $percentage%"
elif [ "$percentage" -ge 41 -a "$percentage" -le 50 ]; then
	echo "<fn=2></fn> $percentage%"
elif [ "$percentage" -ge 51 -a "$percentage" -le 60 ]; then
	echo "<fn=2></fn> $percentage%"
elif [ "$percentage" -ge 61 -a "$percentage" -le 70 ]; then
	echo "<fn=2></fn> $percentage%"
elif [ "$percentage" -ge 71 -a "$percentage" -le 80 ]; then
	echo "<fn=2></fn> $percentage%"
else
	echo "<fn=2></fn> $percentage%"
fi

exit 0

