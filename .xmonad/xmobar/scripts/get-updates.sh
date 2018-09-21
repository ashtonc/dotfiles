#!/bin/bash

list=$(checkupdates)

if [ "$list" == "" ]; then
    count=0
	echo ""
	exit 0
else
    count=`echo "$list" | wc -l`
fi

echo " <fn=2></fn> $count <fc=#595D64>|</fc>"

exit 0

