#!/bin/bash
DIM1_INDICATOR=$HOME/.toggle_redshift_indicator_dim1
DIM2_INDICATOR=$HOME/.toggle_redshift_indicator_dim2
DIM3_INDICATOR=$HOME/.toggle_redshift_indicator_dim3
MIN_INDICATOR=$HOME/.toggle_redshift_indicator_min

DEFAULT_COLOR=$HOME/.xcalib.sh

DIM1_TEMP=5000

DIM2_TEMP=4200

DIM3_TEMP=3500

MIN_TEMP=2200
MIN_BRIGHTNESS=0.6
alias set_min='redshift -P -O $MIN_TEMP -b $MIN_BRIGHTNESS:$MIN_BRIGHTNESS'

set_temp() {
  redshift -P -O $1
}

no_indicators='false'
if [ ! -e $DIM1_INDICATOR ] && \
   [ ! -e $DIM2_INDICATOR ] && \
   [ ! -e $DIM3_INDICATOR ] && \
   [ ! -e $MIN_INDICATOR ]
then
  no_indicators='true'
fi

if [ -n "$1" ] && [ "$1" = "restore" ]; then
  if [ $no_indicators = 'true' ]; then
    . $DEFAULT_COLOR

  elif [ -e $DIM1_INDICATOR ]; then
    set_temp $DIM1_TEMP

  elif [ -e $DIM2_INDICATOR ]; then
    set_temp $DIM2_TEMP

  elif [ -e $DIM3_INDICATOR ]; then
    set_temp $DIM3_TEMP

  elif [ -e $MIN_INDICATOR ]; then
    set_min
  fi
else
  if [ $no_indicators = 'true' ]; then
    touch $DIM1_INDICATOR
    set_temp $DIM1_TEMP

  elif [ -e $DIM1_INDICATOR ]; then
    rm $DIM1_INDICATOR
    touch $DIM2_INDICATOR
    set_temp $DIM2_TEMP

  elif [ -e $DIM2_INDICATOR ]; then
    rm $DIM2_INDICATOR
    touch $DIM3_INDICATOR
    set_temp $DIM3_TEMP

  elif [ -e $DIM3_INDICATOR ]; then
    rm $DIM3_INDICATOR
    touch $MIN_INDICATOR
    set_min

  elif [ -e $MIN_INDICATOR ]; then
    rm $MIN_INDICATOR
    . $DEFAULT_COLOR
  fi
fi
