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

# trackpoint/touchpad settings
sh $HOME/.reset_tp.sh

# mute the spearker
amixer -q -c 1 set Speaker mute

# start easyeffects in background
easyeffects --gapplication-service &

# restore color profile
sh $HOME/.toggle_redshift.sh restore

# background
sh $HOME/.fehbg

# set screen saver blanking time to 1 hour
xset dpms 3600 3600 3600
xset -dpms
xset s blank
xset s 3600

# keyboard
xbindkeys
sudo /usr/local/sbin/kbd_mode_force_unicode.sh

# launch stuff
urxvtd -q -f -o
exec i3
