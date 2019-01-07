# Set caps lock to escape and control
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'

# Set PrtSc key to caps lock
xmodmap -e 'keycode 107 = Caps_Lock'
#xcape -e 'Caps_Lock=Print'

# Initialize xbindkeys
xbindkeys &

# Start Dropbox
killall dropbox
dropbox &

# Set backgrond color
hsetroot -solid "#282C34"

# Start the compositor
compton &

# Start xmonad
exec xmonad

