#!/bin/bash

showupdates="true"
showupdatescount="true"

xmobarspacer="<fc=#595D64>|</fc>"
iconupdates="<fn=2></fn>"
iconnointernet="<fn=2></fn>"

if [ "$showupdates" = "true" ]; then
	wget -q --spider https://google.ca

	if [ $? -eq 0 ]; then
		list=$(checkupdates && yay -Qum)

		if [ "$list" = "" ]; then
			exit 0
		else
			count=`echo "$list" | wc -l`
		fi

		if [ "$showupdatescount" = "true" ]; then
			echo " $iconupdates $count $xmobarspacer"
		else
			echo " $iconupdates $xmobarspacer"
		fi

	else
		echo " $iconnointernet $xmobarspacer"
	fi
fi

exit 0

