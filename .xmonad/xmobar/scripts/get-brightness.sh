#!/bin/bash

showbrightness=$(get-config '.xmobar["show-brightness"]')
showbrightnessstyle=$(get-config '.xmobar["show-brightness-style"]')

precision=0

if [ "$showbrightness" == "true" ]; then
	percentage=$(echo $(xbacklight -get) | xargs printf "%.*f\n" $precision)
	echo "<fn=2></fn> $percentage%"
fi

exit 0

