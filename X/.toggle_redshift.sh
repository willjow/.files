#!/bin/bash
MID_INDICATOR=$HOME/.toggle_redshift_indicator_mid
LOW_INDICATOR=$HOME/.toggle_redshift_indicator_low
MID_TEMP=5000
LOW_TEMP=3500

if [ ! -e $MID_INDICATOR ] && [ ! -e $LOW_INDICATOR ]; then
    touch $MID_INDICATOR
    redshift -P -O $MID_TEMP

elif [ -e $MID_INDICATOR ]; then
    rm $MID_INDICATOR
    touch $LOW_INDICATOR
    redshift -P -O $LOW_TEMP

elif [ -e $LOW_INDICATOR ]; then
    rm $LOW_INDICATOR
    redshift -x
fi
