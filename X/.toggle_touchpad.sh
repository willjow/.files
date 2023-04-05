#!/bin/bash
device="Synaptics TM3053-004"
state=$(xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$")

if [ $state == '1' ]; then
  xinput disable "$device"
  . $HOME/.reset_tp.sh
else
  xinput enable "$device"
fi
