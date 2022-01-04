#!/bin/bash
intern="eDP1"
VGA="VGA1"
HDMI="HDMI1"

choices="VGA\nHDMI\nLaptop"

chosen=$(echo -e "$choices"| dmenu -i -p "Select display" -fn "Hack:size=13:antilias=true:autohint=true" -nb "#222222" -nf "#444444" -sb "#f9906f" -sf "#eeeeee")

case "$chosen"  in
	VGA)
		if xrandr | grep "VGA" | grep -w "connected"; then
			xrandr --output "$HDMI" --off --output "$intern" --off --output "$VGA" --primary --auto
		else 
			xrandr --ouput "$VGA" --off --output "$HDMI" --off --output "$intern" --primary --auto
		fi
		;;
	HDMI)
		if xrandr | grep "HDMI" | grep -w "connected"; then 
			xrandr --ouput "$VGA" --off --output "$intern" --off --output "$HDMI" --primary --auto
		else
			xrandr --output "$VGA" --off --output "$HDMI" --off --output "$intern" --primary --auto
		fi
		;;
	Laptop)
		xrandr --output "$VGA" --off --output "$HDMI" --off --output "$intern" --primary --auto
		;;
esac
