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
tposet "Coordinate Transformation Matrix" 1.8, 0, 0, 0, 1.8, 0, 0, 0, 1
tposet "libinput Accel Speed" 0  # in [-1, 1]
tposet "libinput Accel Profile Enabled" 0, 1, 0  # adaptive, flat, custom
tposet "libinput Scrolling Pixel Distance" 10  # 10 seems to be the min

# touchpad
tpaset "libinput Tapping Enabled" 0
tpaset "libinput Disable While Typing Enabled" 0
tpaset "libinput Accel Speed" -0.09  # in [-1, 1]
tpaset "libinput Accel Profile Enabled" 1, 0, 0  # adaptive, flat, custom

# disable touchpad and buttons
xinput disable "${touchpad}"
