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

green="#98C379"
orange="#E5C07B"
red="#E06C75"

if [ "$charging" = "Charging" ]; then
	if [ "$percentage" -ge 0 -a "$percentage" -le 20 ]; then
		echo "<fn=2></fn> <fc=$green>$percentage</fc>%"
	elif [ "$percentage" -ge 21 -a "$percentage" -le 40 ]; then
		echo "<fn=2></fn> <fc=$green>$percentage</fc>%"
	elif [ "$percentage" -ge 41 -a "$percentage" -le 60 ]; then
		echo "<fn=2></fn> <fc=$green>$percentage</fc>%"
	elif [ "$percentage" -ge 61 -a "$percentage" -le 80 ]; then
		echo "<fn=2></fn> <fc=$green>$percentage</fc>%"
	else
		echo "<fn=2></fn> <fc=$green>$percentage</fc>%"
	fi
else
	if [ "$percentage" -ge 0 -a "$percentage" -le 20 ]; then
		echo "<fn=2></fn> <fc=$red>$percentage</fc>%"
	elif [ "$percentage" -ge 21 -a "$percentage" -le 40 ]; then
		echo "<fn=2></fn> <fc=$red>$percentage</fc>%"
	elif [ "$percentage" -ge 41 -a "$percentage" -le 60 ]; then
		echo "<fn=2></fn> <fc=$orange>$percentage</fc>%"
	elif [ "$percentage" -ge 61 -a "$percentage" -le 80 ]; then
		echo "<fn=2></fn> <fc=$orange>$percentage</fc>%"
	else
		echo "<fn=2></fn> <fc=$green>$percentage</fc>%"
	fi
fi

exit 0

