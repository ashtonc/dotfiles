#!/bin/bash

fullstatus=`pulseaudio-ctl full-status`
mute=`echo $fullstatus | awk '{print $2}'`

if [ "$mute" = "yes" ]; then
	echo "<fn=2></fn>"
else
	volume=`echo $fullstatus | awk '{print $1}'`
	if [ "$volume" = 0 ]; then
		echo "<fn=2></fn>"
	elif [ "$volume" -gt 0 -a "$volume" -le 30 ]; then
		echo "<fn=2></fn> $volume%"
	elif [ "$volume" -gt 30 -a "$volume" -le 65 ]; then
		echo "<fn=2></fn> $volume%"
	else
		echo "<fn=2></fn> $volume%"
	fi
fi

exit 0

