#!/bin/bash

mute=`echo $(pulseaudio-ctl full-status) | awk '{print $2}'`

if [ "$mute" = "yes" ]; then
	echo "M"
else
	volume=`echo $(pulseaudio-ctl full-status) | awk '{print $1}'`
	echo "$volume%"
fi

exit 0
