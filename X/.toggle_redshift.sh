#!/bin/bash
INDICATOR_FILE=/run/user/$(id -u)/redshift-indicator
DEFAULT_COLOR=$HOME/.xcalib.sh
CCT=(5000 4200 3500 2200)
DIM=(1 1 1 0.6)

set_shift() {
    redshift -P -O $1 -b $2:$2
}

reset_temp() {
    redshift -P -x
}

# Make sure indicator file exists
if [[ ! -e $INDICATOR_FILE ]]; then
    echo '-1' > $INDICATOR_FILE
fi

# Set redshift level
i=$(($(< $INDICATOR_FILE) + 1))

if [[ -n "$1" && "$1" = "restore" ]] || (($i >= ${#CCT[@]})); then
    reset_temp
    . $DEFAULT_COLOR
    echo '-1' > $INDICATOR_FILE
else
    set_shift ${CCT[i]} ${DIM[i]}
    echo "$i" > $INDICATOR_FILE
fi
