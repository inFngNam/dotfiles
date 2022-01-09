#!/bin/bash

connected_display=$(xrandr | grep -w 'connected' | awk '{print $1}')
choices="$connected_display"
chosen=$(echo -e "$choices"| dmenu -i -p "Select display" -fn "Hack:size=13:antilias=true:autohint=true" -nb "#222222" -nf "#444444" -sb "#f9906f" -sf "#eeeeee")

VGA="$(echo "$connected_display" | grep 'VGA')"
intern="$(echo "$connected_display" | grep 'DP')"
HDMI="$(echo "$connected_display" | grep 'HDMI')"

case "$chosen"  in
    "$VGA")
    	if [[ "$VGA" != "" ]]; then
            xrandr --output "$VGA" --primary --auto --output "$HDMI" --off --output "$intern" --off
    	else 
    	    xrandr --output "$VGA" --off --output "$HDMI" --off --output "$intern" --primary --auto
    	fi
    	;;
    "$HDMI")
		if [[ "$HDMI" != "" ]]; then 
		    xrandr --output "$VGA" --off --output "$intern" --off --output "$HDMI" --primary --auto
		else
			xrandr --output "$VGA" --off --output "$HDMI" --off --output "$intern" --primary --auto
		fi
		;;
	"$intern")
		xrandr --output "$VGA" --off --output "$HDMI" --off --output "$intern" --primary --auto
		;;
esac
