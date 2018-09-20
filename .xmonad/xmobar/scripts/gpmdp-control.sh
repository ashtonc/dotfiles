#!/bin/sh

action=$1

if [ "$action" = "pause" ]; then
	echo "Pausing..."
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.google-play-music-desktop-player /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause > /dev/null 2>&1
elif [ "$action" = "play" ]; then
	echo "Playing..."
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.google-play-music-desktop-player /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play > /dev/null 2>&1
elif [ "$action" = "pauseplay" ]; then
	echo "Toggling pause/play..."
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.google-play-music-desktop-player /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null 2>&1
elif [ "$action" = "next" ]; then
	echo "Next..."
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.google-play-music-desktop-player /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next > /dev/null 2>&1
elif [ "$action" = "previous" ]; then
	echo "Previous..."
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.google-play-music-desktop-player /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous > /dev/null 2>&1
elif [ "$action" = "thumbsup" ]; then
	echo "Thumbs up..."

elif [ "$action" = "thumbsdown" ]; then
	echo "Thumbs down..."

elif [ "$action" = "getinfo" ]; then
	dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.google-play-music-desktop-player /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'
else
	echo "Invalid action."
fi

