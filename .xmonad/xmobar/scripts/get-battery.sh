#!/bin/bash

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
powerdraw=$(bc <<< "scale=1; $(cat /sys/class/power_supply/BAT1/power_now)/1000000")

green="#98C379"
orange="#E5C07B"
red="#E06C75"

if [ "$charging" = "Charging" ]; then
	echo "<fn=2></fn> <fc=$green>$percentage</fc>%"
else
	if [ "$percentage" -ge 0 -a "$percentage" -le 20 ]; then
		echo "<fn=2></fn> <fc=$red>$percentage</fc>% (${powerdraw}W)"
	elif [ "$percentage" -ge 21 -a "$percentage" -le 30 ]; then
		echo "<fn=2></fn> <fc=$red>$percentage</fc>% (${powerdraw}W)"
	elif [ "$percentage" -ge 31 -a "$percentage" -le 50 ]; then
		echo "<fn=2></fn> <fc=$orange>$percentage</fc>% (${powerdraw}W)"
	elif [ "$percentage" -ge 51 -a "$percentage" -le 70 ]; then
		echo "<fn=2></fn> <fc=$orange>$percentage</fc>% (${powerdraw}W)"
	else
		echo "<fn=2></fn> <fc=$green>$percentage</fc>% (${powerdraw}W)"
	fi
fi

exit 0

