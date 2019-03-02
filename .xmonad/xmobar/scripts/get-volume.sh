#!/bin/bash

showvolume=$(get-config '.xmobar["show-volume"]')
showvolumeamount=$(get-config '.xmobar["show-volume-amount"]')
showvolumestyle=$(get-config '.xmobar["show-volume-style"]')

xmobarspacer=""
iconmute="<fn=2></fn>"
iconnilvolume="<fn=2></fn>"
iconlowvolume="<fn=2></fn>"
iconmedvolume="<fn=2></fn>"
iconhighvolume="<fn=2></fn>"

if [ "$showvolume" = "true" ]; then
	fullstatus=`pulseaudio-ctl full-status`
	mute=`echo $fullstatus | awk '{print $2}'`

	if [ "$mute" = "yes" ]; then
		showvolumeamount="false"
		icon=$iconmute
	else
		volume=`echo $fullstatus | awk '{print $1}'`

		if [ "$volume" = 0 ]; then
			showvolumeamount="false"
			icon=$iconnilvolume
		elif [ "$volume" -gt 0 -a "$volume" -le 30 ]; then
			icon=$iconlowvolume
		elif [ "$volume" -gt 30 -a "$volume" -le 65 ]; then
			icon=$iconmedvolume
		else
			icon=$iconhighvolume
		fi
	fi

	if [ "$showvolumeamount" = "true" ]; then
		echo "$icon $volume%"
	else
		echo "$icon"
	fi
fi

exit 0

