#!/bin/bash

showbluetooth="true"
xmobarspacer="<fc=#595D64>|</fc>"
iconbluetooth="<fn=3></fn>"

if [ "$showbluetooth" = "true" ]; then
	btstatus=$(bluetooth)

	if [[ "$btstatus" != *"= off"* ]]; then
		echo "$xmobarspacer $iconbluetooth "
	fi
fi

exit 0

