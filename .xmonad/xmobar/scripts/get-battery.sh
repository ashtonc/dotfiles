#!/bin/bash

showbattery=$(get-config '.xmobar["show-battery"]')
showbatteryicon=$(get-config '.xmobar["show-battery-icon"]')
showbatterypercentage=$(get-config '.xmobar["show-battery-percentage"]')
showbatterywatts=$(get-config '.xmobar["show-battery-watts"]')

iconcharging="<fn=2></fn>"
iconbatterynil="<fn=2></fn>"
iconbatterylow="<fn=2></fn>"
iconbatterymed="<fn=2></fn>"
iconbatteryhigh="<fn=2></fn>"
iconbatteryfull="<fn=2></fn>"

colorlow="#E06C75"
colormed="#E5C07B"
colorhigh="#98C379"

if [ "$showbattery" = "true" ]; then
	precision=0
	info=$(acpi -i)

	charging=`echo "$info" | grep 'arging' | awk '{print $3}' | sed 's/,//g'`

	battery0capacity=`echo "$info" | grep 'Battery 0.*capacity' | awk '{print $10}'`
	battery1capacity=`echo "$info" | grep 'Battery 1.*capacity' | awk '{print $10}'`
	totalcapacity=`expr $battery0capacity + $battery1capacity`
	battery0percent=`echo "$info" | grep 'Battery 0' | grep -v 'capacity' | awk '{print $4}' | grep -o '[0-9]\+'`
	battery1percent=`echo "$info" | grep 'Battery 1' | grep -v 'capacity' | awk '{print $4}' | grep -o '[0-9]\+'`

	let totalcharge="(($battery0percent * battery0capacity / 100) + ($battery1percent * battery1capacity / 100))"
	let percentage="100 * $totalcharge / $totalcapacity"

	powerdraw0=$(cat /sys/class/power_supply/BAT0/power_now)
	powerdraw1=$(cat /sys/class/power_supply/BAT1/power_now)
	powerdraw=$(bc <<< "scale=1; $(expr $powerdraw0 + $powerdraw1)/1000000")

	green="#98C379"
	orange="#E5C07B"
	red="#E06C75"

	if [ "$charging" = "Charging" ]; then
		icon=""
		color_prefix="<fc=$green>"
	else
		if [ "$percentage" -ge 0 -a "$percentage" -le 20 ]; then
			icon=""
			color_prefix="<fc=$red>"
		elif [ "$percentage" -ge 21 -a "$percentage" -le 30 ]; then
			icon=""
			color_prefix="<fc=$red>"
		elif [ "$percentage" -ge 31 -a "$percentage" -le 50 ]; then
			icon=""
			color_prefix="<fc=$orange>"
		elif [ "$percentage" -ge 51 -a "$percentage" -le 70 ]; then
			icon=""
			color_prefix="<fc=$orange>"
		else
			icon=""
			color_prefix="<fc=$green>"
		fi
	fi

	icon_prefix="<fn=2>"
	icon_suffix="</fn>"
	color_suffix="</fc>"

	if [ "$showbatteryicon" = "true" ]; then
		icon="$icon_prefix$icon$icon_suffix"
	fi

	if [ "$showbatterypercentage" = "true" ]; then
		percentage=" $color_prefix$percentage$color_suffix%"
	fi

	if [ "$showbatterywatts" = "true" ]; then
		powerdraw=" (${powerdraw}W)"
	fi

	echo "$icon$percentage$powerdraw"
fi

exit 0

