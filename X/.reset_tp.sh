#!/bin/sh
trackpoint="TPPS/2 IBM TrackPoint"
touchpad="Synaptics TM3053-004"

# enable before changing settings
xinput enable "${touchpad}"
xinput enable "${touchpad}"

# settings
tposet() { xinput set-prop "${trackpoint}" "$@"; }
tpaset() { xinput set-prop "${touchpad}" "$@"; }

tposet "libinput Accel Speed" 0.8  # in [-1, 1]
tposet "libinput Accel Profile Enabled" 0, 1  # adaptive, flat
tpaset "libinput Tapping Enabled" 0
tpaset "libinput Disable While Typing Enabled" 0

# disable touchpad and buttons
xinput disable "${touchpad}"
