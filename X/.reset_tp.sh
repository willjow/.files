#!/bin/sh
trackpoint="TPPS/2 IBM TrackPoint"
touchpad="Synaptics TM3053-004"

# enable before changing settings
xinput enable "${trackpoint}"
xinput enable "${touchpad}"

# settings
tposet() { xinput set-prop "${trackpoint}" "$@"; }
tpaset() { xinput set-prop "${touchpad}" "$@"; }

# trackpoint
tposet "libinput Accel Speed" 0.45  # in [-1, 1]
tposet "libinput Accel Profile Enabled" 0, 1  # adaptive, flat

# touchpad
tpaset "libinput Tapping Enabled" 0
tpaset "libinput Disable While Typing Enabled" 0
tpaset "libinput Accel Speed" -0.11  # in [-1, 1]
tpaset "libinput Accel Profile Enabled" 1, 0  # adaptive, flat

# disable touchpad and buttons
xinput disable "${touchpad}"
