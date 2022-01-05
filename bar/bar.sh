#!/bin/bash

# colorrs
black=#1e222a
green=#7eca9c
white=#abb2bf
grey=#282c34
blue=#7aa2f7
red=#d47d85
darkblue=#668ee3
yellow=#d4d17d

# init count variables
total_unreaded_mails="$(python $HOME/dotfiles/bar/get_unreaded_mail.py)"
total_updatable_packages="$(checkupdates | wc -l)"

last_updated="$(grep 'upgraded' /var/log/pacman.log | tail -1 | awk '{print substr($1, 2, length($1)-7)}')"
last_checkupdates="$(date --iso-8601=seconds | awk '{print substr($1, 1, length($1) - 6)}')"

# functions values
clock() {
	printf "^c$white^[ ^c$white^$(date '+%a %b %d %Y, %H:%M:%S')]"
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
				printf "[^c$blue^直 $wifi^c$white^]"
				;;
			down)
				printf "[^c$blue^睊 Disconnected^c$white^]"
				;;
		esac
	else
		printf "[^c$blue^ Ethernet ^c$white^]"
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

unreaded_mails(){
	if [[ $total_unreaded_mails -ne 0 ]];
	then
		printf "^c$white^[^c$red^ $total_unreaded_mails^c$white^]"
	fi
}

audio(){
	volume="$(pamixer --get-volume)"
	if [[ $volume -eq 0 ]];
	then
		printf "^c$white^[^c$green^ﱝ^c$white^]"
	elif [[ $volume -lt 30 ]];
	then
		printf "^c$white^[^c$green^奄 $volume^c$white^]"
	elif [[ $volumn -ge 30 ]] && [[ $volumn -lt 65 ]];
	then
		printf "^c$white^[^c$green^奔 $volume^c$white^]"
	else
		printf "^c$white^[^c$green^墳 $volume^c$white^]"
	fi
}

updatable_packages(){
	last_updated="$(grep 'upgraded' /var/log/pacman.log | tail -1 | awk '{print substr($1, 2, length($1)-7)}')"
	if [[ "$last_updated" > "$last_checkupdates" ]];
	then
		total_update_packages=0
	fi

	if [[ $total_updatable_packages -ne 0 ]];
	then
		printf "^c$white^[^b$grey^^c$green^ $total_updatable_packages^b$black^^c$white^]"
	fi
}

#update some values
function get_unreaded_mails {
	total_unreaded_mails="$(python $HOME/dotfiles/bar/get_unreaded_mail.py)"
}

function get_updatable_packages {
	total_updatable_packages="$(checkupdates | wc -l)"
	last_checkupdates="$(date --iso-8601=seconds | awk '{print substr($1, 1, length($1) - 6)}')"
}

# loops

# update loop (For not does not affect the main loop)
# get mails every 5 minutes
updatable_packages_loop_count=0
while true; do
	get_unreaded_mails
	# get packages every 30 minutes
	if [[ $updatable_package_loop_count -eq 6 ]];
	then
		get_updatable_packages
		updatable_packages_loop_count=0
	else
		updatable_packages_loop_count=$((updatable_packages_loop_count+1))
	fi
	sleep 300;
done &

# main loop
while true; do
	xsetroot -name "$(updatable_packages)$(unreaded_mails)$(temperature)$(cpu)$(battery)$(internet_connection)$(audio)$(clock)"
	sleep 1;
done &
