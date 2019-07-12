#!/bin/bash
DIM1_INDICATOR=$HOME/.toggle_redshift_indicator_dim1
DIM2_INDICATOR=$HOME/.toggle_redshift_indicator_dim2
DIM3_INDICATOR=$HOME/.toggle_redshift_indicator_dim3

DIM1_GAMMA='1:1:1'
DIM1_TEMP=5000

DIM2_GAMMA='1:1:1'
DIM2_TEMP=4200

DIM3_GAMMA='1:1:1'
DIM3_TEMP=3500

if [ ! -e $DIM1_INDICATOR ] && [ ! -e $DIM2_INDICATOR ] && [ ! -e $DIM3_INDICATOR ]; then
  touch $DIM1_INDICATOR
  redshift -P -g $DIM1_GAMMA -O $DIM1_TEMP

elif [ -e $DIM1_INDICATOR ]; then
  rm $DIM1_INDICATOR
  touch $DIM2_INDICATOR
  redshift -P -g $DIM2_GAMMA -O $DIM2_TEMP

elif [ -e $DIM2_INDICATOR ]; then
  rm $DIM2_INDICATOR
  touch $DIM3_INDICATOR
  redshift -P -g $DIM3_GAMMA -O $DIM3_TEMP

elif [ -e $DIM3_INDICATOR ]; then
  rm $DIM3_INDICATOR
  redshift -x
fi
