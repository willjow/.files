#!/bin/bash

# After running this script, run `pavucontrol`.
#
# In `pavucontrol`, go to the "Recording tab", where you should see "WEBRTC
# VoiceEngine". If not, make sure discord is open and in a call. To the right,
# you should see a dropdown menu that says "Built-in Analog Audio" or similar.
# Change this to "Monitor of combined_output".
#
# Now, to send the sound you want to stream to that null output, open the
# "Playback" tab and find the program you want to stream (make sure the program
# is outputting audio). Then, change the right dropdown to be "recorded_sink".
#
# To disable this, just `systemctl --user restart pulseaudio`. You should reset
# anything that uses audio after restarting pulseaudio.

MIC_SOURCE=alsa_input.pci-0000_00_1b.0.analog-stereo
SPEAKER_SINK=alsa_output.pci-0000_00_1b.0.analog-stereo

pactl load-module module-null-sink sink_name=combined_output sink_properties=device.description=combined_output
pactl load-module module-null-sink sink_name=recorded_sink sink_properties=device.description=recorded_sink
pactl load-module module-loopback source=$MIC_SOURCE sink=combined_output
pactl load-module module-loopback source=recorded_sink.monitor sink=combined_output
pactl load-module module-loopback source=recorded_sink.monitor sink=$SPEAKER_SINK
