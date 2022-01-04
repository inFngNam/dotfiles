#! /usr/bash


a="$(date --iso-8601=seconds | awk '{print substr($1, 1, length($1) - 6)}')"

b="$(grep 'upgraded' /var/log/pacman.log | tail -1 | awk '{print substr($1, 2, length($1)-7)}')"
if [[ "$b" > "$a" ]] ;
then
	echo "break"
fi
