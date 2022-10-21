#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xcompmgr &
dunst &
~/.fehbg &
# conky &
# slstatus &
#exec dwm
/usr/lib/kdeconnectd &
exec spectrwm
#exec herbstluftwm --locked
