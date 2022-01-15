#!/bin/sh

export PATH="$PATH:$HOME/dotfiles/shell:$HOME/local/.bin"
connected_display=$(xrandr | grep -w 'connected' | awk '{print $1}')
VGA="$(echo "$connected_display" | grep 'VGA')"
intern="$(echo "$connected_display" | grep 'DP')"
HDMI="$(echo "$connected_display" | grep 'HDMI')"

# start status bar
sh $HOME/dotfiles/bar/bar.sh
    
# start background
nitrogen --restore &
picom &

# start ibus
ibus-daemon -drxR

# display monitor
if [[ "$VGA" != "" ]];
then
    xrandr --output "$HDMI" --off --output "$intern" --off --output "$VGA" --primary --auto
elif [[ "$HDMI" != "" ]];
then
    xrandr --output "$VGA" --off --output "$intern" --off --output "$HDMI" --primary --auto
else
	xrandr --output "$VGA" --off --output "$HDMI" --off --output "$intern" --primary --auto
fi
   
# start stalonetray
stalonetray -c ~/.config/stalonetray/stalonestrayrc --kludges=force_icons_size &
exec dwm
