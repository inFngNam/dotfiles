#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

export PATH="$PATH:$HOME/dotfiles/shell:$HOME/local/.bin"

connected_display=$(xrandr | grep -w 'connected' | awk '{print $1}')

VGA="$(echo "$connected_display" | grep 'VGA')"
intern="$(echo "$connected_display" | grep 'DP')"
HDMI="$(echo "$connected_display" | grep 'HDMI')"

# For startx ~/.xinitrc 'dwm'
session=${1:-dwm}

if [[ $session == 'cinnamon' ]];
then
    exec cinnamon-session
else
    sh $HOME/dotfiles/bar/bar.sh
    nitrogen --restore &
    picom &


    if [[ "$VGA" != "" ]];
    then
        xrandr --output "$HDMI" --off --output "$intern" --off --output "$VGA" --primary --auto
    elif [[ "$HDMI" != "" ]];
    then
        xrandr --output "$VGA" --off --output "$intern" --off --output "$HDMI" --primary --auto
    else
		xrandr --output "$VGA" --off --output "$HDMI" --off --output "$intern" --primary --auto
    fi

    exec dwm
fi
