xmodmap -e 'keycode 107 = Caps_Lock'
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'
#xcape -e 'Caps_Lock=Print'

exec xmonad
