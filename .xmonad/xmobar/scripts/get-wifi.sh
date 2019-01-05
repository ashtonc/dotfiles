#!/bin/bash

wifipowerstatus=$(wifi)

if [[ "$wifipowerstatus" == *"= off"* ]]; then
	echo "<fn=2></fn>"
else
	ssid=$(iwgetid -r)
	if [ "$ssid" == "" ]; then
		echo "<fn=2></fn>"
	else
		frequency=$(iwlist wlp4s0 channel | grep Current | sed 's/\(.*\):\(.*\) GHz\(.*\)/\2/g')
		linkquality=$(awk 'NR==3 {print $3}' /proc/net/wireless | grep -o '[0-9]\+')
		maxlinkquality=70
		linkqualitypercent=$(awk "BEGIN { pc=100*${linkquality}/${maxlinkquality}; i=int(pc); print (pc-i<0.5)?i:i+1 }")

		if [ "$linkqualitypercent" -ge 0 -a "$linkqualitypercent" -le 40 ]; then
			echo "<fn=2></fn> $ssid (${frequency}GHz)"
		elif [ "$linkqualitypercent" -gt 40 -a "$linkqualitypercent" -le 70 ]; then
			echo "<fn=2></fn> $ssid (${frequency}GHz)"
		else
			echo "<fn=2></fn> $ssid (${frequency}GHz)"
		fi
	fi
fi

