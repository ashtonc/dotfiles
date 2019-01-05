#!/bin/bash

precision=0
percentage=$(echo $(xbacklight -get) | xargs printf "%.*f\n" $precision)

echo "<fn=2></fn> $percentage%"

exit 0

