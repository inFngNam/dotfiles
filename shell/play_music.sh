#!/usr/bash

check_mpd_running="$(netstat -tln | grep '6600' | wc -l)"

if [[ $check_mpd_running == 0 ]];
then
    mpd
fi

ncmpcpp
