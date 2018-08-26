#!/bin/bash

fullstatus=`pulseaudio-ctl full-status`
mute=`echo $fullstatus | awk '{print $2}'`

if [ "$mute" = "yes" ]; then
	echo "<fn=2></fn>"
	exit 0
fi

volume=`echo $fullstatus | awk '{print $1}'`

if [ "$volume" = 0 ]; then
	echo "<fn=2></fn> $volume%"
elif [ "$volume" -ge 1 -a "$volume" -le 50 ]; then
	echo "<fn=2></fn> $volume%"
else
	echo "<fn=2></fn> $volume%"
fi

exit 0

