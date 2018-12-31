#!/bin/bash

list=$(checkupdates && yay -Qum)

if [ "$list" != "" ]; then
    count=`echo "$list" | wc -l`
	echo " <fn=2></fn> $count <fc=#595D64>|</fc>"
fi

exit 0

