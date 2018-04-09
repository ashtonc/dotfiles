setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'
xmodmap -e 'keycode 107 = Caps_Lock'
#xcape -e 'Caps_Lock=Print'

exec xmonad
