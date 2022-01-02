#!/bin/bash
intern="eDP-1"

choices="VGA\nHDMI\nLaptop"

chosen=$(echo -e "$choices"| dmenu -i -p "Select display")
case "$chosen"  in
	VGA)
		if xrandr | grep "VGA-1 connected"; then
			xrandr --output "HDMI-1" --off --output "$intern" --off --output "VGA-1" --primary --auto
		else 
			xrandr --ouput "VGA-1" --off --output "$intern" --off --output "HDMI-1" --primary --auto
		fi
		;;
	HDMI)
		if xrandr | grep "HDMI-1 connected"; then 
			xrandr --ouput "VGA-1" --off --output "$intern" --off --output "HDMI-1" --primary --auto
		else
			xrandr --output "VGA-1" --off --output "HDMI-1" --off --output "$intern" --primary --auto
		fi
		;;
	Laptop)
		xrandr --output "VGA-1" --off --output "HDMI-1" --off --output "$intern" --primary --auto
		;;
esac
