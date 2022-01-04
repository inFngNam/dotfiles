#!/bin/bash

#colorrs
black=#1e222a
green=#7eca9c
white=#abb2bf
grey=#282c34
blue=#7aa2f7
red=#d47d85
darkblue=#668ee3
yellow=#d4d17d

clock() {
	printf "^c$black^^b$blue^[ $(date '+%a %b %d %Y, %H:%M:%S')]"
}

battery() {
	charge_status="$(cat /sys/class/power_supply/BAT0/status)"
	capacity="$(cat /sys/class/power_supply/BAT0/capacity)"

	if [[ $charge_status == "Discharging" ]];
	then
		if [[ $capacity -lt 10 ]]; 
		then
			printf "^c$white^[^c$red^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 10  ]] && [[ $capacity -lt 20 ]];
		then
			printf "^c$white^[^c$red^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 20  ]] && [[ $capacity -lt 30 ]];   	     
		then
			printf "^c$white^[^c$red^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 30  ]] && [[ $capacity -lt 40 ]];
		then
			printf "^c$white^[^c$yellow^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 40  ]] && [[ $capacity -lt 50 ]];
		then
			printf "^c$white^[^c$yellow^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 50  ]] && [[ $capacity -lt 60 ]];
		then
			printf "^c$white^[^c$yellow^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 60  ]] && [[ $capacity -lt 70 ]];
		then
			printf "^c$white^[^c$yellow^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 70  ]] && [[ $capacity -lt 80 ]];
		then
			printf "^c$white^[^c$yellow^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 80  ]] && [[ $capacity -lt 90 ]];
		then
			printf "^c$white^[^c$green^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 90  ]] && [[ $capacity -lt 100 ]];
		then
			printf "^c$white^[^c$green^ $capacity%%^c$white^]"
		else
			printf "^c$white^[^c$green^ $capacity%%^c$white^]"
		fi

	else 
		if [[ $capacity -lt 10 ]]; 
		then
			printf "^c$white^[^c$red^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 10  ]] && [[ $capacity -lt 30 ]];   	     
		then
			printf "^c$white^[^c$red^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 30  ]] && [[ $capacity -lt 40 ]];
		then
			printf "^c$white^[^c$red^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 40  ]] && [[ $capacity -lt 60 ]];
		then
			printf "^c$white^[^c$yellow^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 60  ]] && [[ $capacity -lt 80 ]];
		then
			printf "^c$white^[^c$yellow^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 80  ]] && [[ $capacity -lt 90 ]];
		then
			printf "^c$white^[^c$green^ $capacity%%^c$white^]"
		elif [[ $capacity -ge 90  ]] && [[ $capacity -lt 100 ]];
		then
			printf "^c$white^[^c$green^ $capacity%%^c$white^]"
		else
			printf "^c$white^[^c$green^ $capacity%%^c$white^]"
		fi
	fi
}


internet_connection() {
	etherport_check="$(cat /sys/class/net/eno1/carrier)"
	if [[ $etherport_check == '0' ]];
	then
		case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
			up)
				wifi=$(iw wlan0 link | grep SSID| awk '{print $2}')
				printf "^c$black^ ^b$blue^ 直 ^d^%s" " ^c$blue^$wifi" 
				;;
			down)
				printf "^c$black^ ^b$blue^ 睊 ^d^%s" " ^c$blue^Disconnected"
				;;
		esac
	else
		printf "^c$black^ ^b$blue^  ^d^%s" " ^c$blue^Ethernet" 
	fi
}

cpu() {
	cpu_value=$(grep -o "^[^ ]*" /proc/loadavg)
	printf "^c$white^^b$grey^[﬙ $cpu_value]^b$black^"
}

temperature(){
	value=$(sensors | grep "Package id 0" | awk '{print $4}' | grep -o '[0-9]*' | head -1)
	if [[ value -lt 75 ]];
	then
		printf "^c$white^[^c$green^$value 糖^c$white^]^c$black^"
	elif [[ value -lt 85 ]];
	then
		printf "^c$white^[^c$yellow^$value 糖^c$white^]^c$black^"
	else
		printf "^c$white^[^c$red^$value 糖^c$white^]^c$black^"
	fi
}

xsetroot -name "$(temperature)$(cpu)$(battery)$(internet_connection) $(clock)"
