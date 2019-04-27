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

# trackpoint stuff
tpset() { xinput set-prop "TPPS/2 IBM TrackPoint" "$@"; }

# not working as of update on Nov 8 2017
# tpset "Evdev Wheel Emulation" 1
# tpset "Evdev Wheel Emulation Button" 2
# tpset "Evdev Wheel Emulation Timeout" 200
# tpset "Evdev Wheel Emulation Axes" 6 7 4 5
# tpset "Device Accel Constant Deceleration" 0.55
tpset "libinput Accel Speed" 0.9
tpset "libinput Accel Profile Enabled" 0, 1

# disable touchpad and buttons
xinput disable "SynPS/2 Synaptics TouchPad"
xinput set-button-map "SynPS/2 Synaptics TouchPad" 0 0 0 4 5 6 7

# second monitor
xrandr --output LVDS1 --primary --auto --output VGA1 --auto --right-of LVDS1

# background
sh ~/.fehbg

# launch stuff
xbindkeys
exec i3
