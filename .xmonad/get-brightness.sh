#!/bin/bash

precision=0
echo $(xbacklight -get) | xargs printf "%.*f\n" $precision

exit 0
