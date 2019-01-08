#!/bin/sh

# Variables

intent=$1

property=$2
action=$2

destination="org.mpris.MediaPlayer2.google-play-music-desktop-player"
interface="/org/mpris/MediaPlayer2"
string="org.mpris.MediaPlayer2.Player"
properties="org.freedesktop.DBus.Properties.Get"

script="/home/ashton/.xmonad/xmobar/scripts/gpmdp-control.sh"

# Functions

us_to_min()
{
	microseconds=$1

	let seconds=$microseconds/1000000
	let minutes=$seconds/60
	let remainder=$seconds%60

	paddedseconds=$(printf %02d $remainder)

	time=$minutes:$paddedseconds
}

get_info()
{
	track=$($script get track)
	artist=$($script get artist)
	position=$($script get position)
	length=$($script get length)
}

# Debug, show available metadata`

if [ "$intent" = "debug" ]; then
	dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'Metadata'
elif [ "$intent" = "get" ]; then
	if [ "$property" = "track" ]; then
		dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'Metadata' \
		| grep -A1 "xesam:title" | tail -1 | cut -d '"' -f 2
	elif [ "$property" = "artist" ]; then
		# This returns only the first artist in the array
		dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'Metadata' \
		| grep -A2 "xesam:artist" | tail -1 | cut -d '"' -f 2
	elif [ "$property" = "album" ]; then
		dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'Metadata' \
		| grep -A1 "xesam:album" | tail -1 | cut -d '"' -f 2
	elif [ "$property" = "arturl" ]; then
		dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'Metadata' \
		| grep -A1 "mpris:artUrl" | tail -1 | cut -d '"' -f 2
	elif [ "$property" = "length" ]; then
		us_to_min $(dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'Metadata' \
		| grep -A1 "mpris:length" | tail -1 | awk '{ print $NF }')
		echo $time
	elif [ "$property" = "position" ]; then
		us_to_min $(dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'Position' \
		| grep -o " [a-Z0-9]*$" )
		echo $time
	elif [ "$property" = "playbackstatus" ]; then
		dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'PlaybackStatus' \
		| grep "variant" | cut -d '"' -f 2
	elif [ "$property" = "shufflestatus" ]; then
		dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'Shuffle' \
		| grep "variant" | awk '{ print $NF }'
	elif [ "$property" = "loopstatus" ]; then
		dbus-send --print-reply --session --dest=$destination $interface $properties string:$string string:'LoopStatus' \
		| grep "variant" | cut -d '"' -f 2
	else
		echo "Invalid property."
		exit 1
	fi
elif [ "$intent" = "do" ]; then
	if [ "$action" = "pauseplay" ]; then
		echo "Toggling pause/play..."
		dbus-send --print-reply --dest=$destination $interface org.mpris.MediaPlayer2.Player.PlayPause > /dev/null 2>&1
	elif [ "$action" = "play" ]; then
		echo "Playing..."
		dbus-send --print-reply --dest=$destination $interface org.mpris.MediaPlayer2.Player.Play > /dev/null 2>&1
	elif [ "$action" = "pause" ]; then
		echo "Pausing..."
		dbus-send --print-reply --dest=$destination $interface org.mpris.MediaPlayer2.Player.Pause > /dev/null 2>&1
	elif [ "$action" = "stop" ]; then
		echo "Stopping..."
		dbus-send --print-reply --dest=$destination $interface org.mpris.MediaPlayer2.Player.Stop > /dev/null 2>&1
	elif [ "$action" = "next" ]; then
		echo "Next track..."
		dbus-send --print-reply --dest=$destination $interface org.mpris.MediaPlayer2.Player.Next > /dev/null 2>&1
	elif [ "$action" = "previous" ]; then
		echo "Previous track..."
		dbus-send --print-reply --dest=$destination $interface org.mpris.MediaPlayer2.Player.Previous > /dev/null 2>&1
	elif [ "$action" = "thumbsup" ]; then
		echo "Thumbs up..."
		# Not implemented yet
	elif [ "$action" = "thumbsdown" ]; then
		echo "Thumbs down..."
		# Not implemented yet
	else
		echo "Invalid action."
	fi
elif [ "$intent" = "bar" ]; then
	playbackstatus=$($script get playbackstatus)
	
	if [ "$playbackstatus" = "Playing" ]; then
#		get_info
		echo "<action=$script do pauseplay> <fn=2></fn> </action><fc=#595D64>|</fc>"
	fi

	if [ "$playbackstatus" = "Paused" ]; then
#		get_info
		echo "<action=$script do pauseplay> <fn=2></fn> </action><fc=#595D64>|</fc>"
	fi
else
	echo "Invalid intent."
	exit 1
fi

exit 0

