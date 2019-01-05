#!/bin/bash

wget -q --spider https://google.ca

if [ $? -eq 0 ]; then
	list=$(checkupdates && yay -Qum)
	if [ "$list" != "" ]; then
		count=`echo "$list" | wc -l`
		echo " <fn=2></fn> $count <fc=#595D64>|</fc>"
	fi
else
	echo " <fn=2></fn> <fc=#595D64>|</fc>"
fi

exit 0

