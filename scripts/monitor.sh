#!/bin/bash
intern="eDP-1"

read -n 1 -p "Monitor options: Intern, VGA, HDMI? (i/v/h)" answer;

case $answer in
	v|V)
		if xrandr | grep "VGA-1 connected"; then
			xrandr --output "HDMI-1" --off --output "$intern" --off --output "VGA-1" --primary --auto
			exit 1;
		fi
		;;
	h|H)
		if xrandr | grep "HDMI-1 connected"; then 
			xrandr --ouput "VGA-1" --off --output "$intern" --off --output "HDMI-1" --primary --auto
			exit 1;
		fi
		;;	
esac
xrandr --output "VGA-1" --off --output "HDMI-1" --off --output "$intern" --primary --auto
