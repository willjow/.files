#!/bin/bash
TOGGLE=$HOME/.redshift_indicator
TEMPERATURE=3500

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    redshift -P -O $TEMPERATURE
else
    rm $TOGGLE
    redshift -x
fi
