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
# Custom acceleration function generated with
# `windows-acceleration-function.py`, linked at the bottom of the libinput
# merge request:
# https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/775
tpaset "libinput Tapping Enabled" 0
tpaset "libinput Disable While Typing Enabled" 0
tpaset "libinput Accel Speed" 0  # in [-1, 1]
tpaset "libinput Accel Profile Enabled" 0, 0, 1  # adaptive, flat, custom
tpaset "libinput Accel Custom Motion Points" 0.000, 0.079, 0.159, 0.274, 0.393, 0.512, 0.632, 0.804, 0.985, 1.167, 1.348, 1.529, 1.711, 1.892, 2.074, 2.255, 2.436, 2.618, 2.799, 2.981, 3.355
tpaset "libinput Accel Custom Motion Step" 0.2031610269
tpaset "libinput Scrolling Pixel Distance" 25

# disable touchpad and buttons
xinput disable "${touchpad}"
