#!/bin/bash

showwifi="true"
showwifissid="true"
showwififrequency="true"
showwifiupload="false"
showwifidownload="false"

iconwifioff="<fn=2></fn>"
iconwifinil="<fn=2></fn>"
iconwifilow="<fn=2></fn>"
iconwifimed="<fn=2></fn>"
iconwifihigh="<fn=2></fn>"

iconupload="<fn=2></fn>"
icondownload="<fn=2></fn>"

if [ "$showwifi" == "true" ]; then
	wifipowerstatus=$(wifi)

	if [[ "$wifipowerstatus" == *"= off"* ]]; then
		showwifissid="false"
		showwififrequency="false"
		showwifiupload="false"
		showwifidownload="false"
		icon=$iconwifioff
	else
		ssid=$(iwgetid -r)

		if [ "$ssid" == "" ]; then
			showwifissid="false"
			showwififrequency="false"
			showwifiupload="false"
			showwifidownload="false"
			icon=$iconwifinil
		else
			linkquality=$(awk 'NR==3 {print $3}' /proc/net/wireless | grep -o '[0-9]\+')
			maxlinkquality=70
			linkqualitypercent=$(awk "BEGIN { pc=100*${linkquality}/${maxlinkquality}; i=int(pc); print (pc-i<0.5)?i:i+1 }")

			if [ "$linkqualitypercent" -ge 0 -a "$linkqualitypercent" -le 40 ]; then
				icon=$iconwifilow
			elif [ "$linkqualitypercent" -gt 40 -a "$linkqualitypercent" -le 70 ]; then
				icon=$iconwifimed
			else
				icon=$iconwifihigh
			fi
		fi
	fi

	if [ "$showwifissid" == "true" ]; then
		ssid=" $ssid"
	else
		ssid=""
	fi

	if [ "$showwififrequency" == "true" ]; then
		frequency=$(iwlist wlp4s0 channel | grep Current | sed 's/\(.*\):\(.*\) GHz\(.*\)/\2/g')
		frequency=" (${frequency}GHz)"
	else
		frequency=""
	fi

	if [ "$showwifiupload" == "true" ]; then
		upload=$(ifstat -z | grep 'wlp4s0' | awk '{print $8}')
		upload=" ${iconupload}${upload}"
	else
		upload=""
	fi
	   
	if [ "$showwifidownload" == "true" ]; then
		download=$(ifstat -z | grep 'wlp4s0' | awk '{print $6}')
		download=" ${icondownload}${download}"
	else
		download=""
	fi

	echo "$icon$ssid$frequency$upload$download"
fi

exit 0

