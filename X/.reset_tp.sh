#!/bin/sh
trackpoint="TPPS/2 IBM TrackPoint" 
touchpad="Synaptics TM3053-004" 

# enable before changing settings
xinput enable "${touchpad}"
xinput enable "${touchpad}"

# trackpoint stuff
tposet() { xinput set-prop "${trackpoint}" "$@"; }
tpaset() { xinput set-prop "${touchpad}" "$@"; }

tposet "libinput Accel Speed" 0
tposet "libinput Accel Profile Enabled" 0, 1
tpaset "libinput Tapping Enabled" 1

# disable touchpad and buttons
xinput disable "${touchpad}"
