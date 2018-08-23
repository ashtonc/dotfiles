#!/bin/bash

precision=0
percentage=$(echo $(xbacklight -get) | xargs printf "%.*f\n" $precision)

echo "$percentage%"

exit 0
