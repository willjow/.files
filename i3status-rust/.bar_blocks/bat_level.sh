#!/bin/bash

charge_start_thresh=$1
charge_stop_thresh=$2
bat=${3:-0}

charge_status=$(cat /sys/class/power_supply/BAT${bat}/status)

energy_now=$(cat /sys/class/power_supply/BAT${bat}/energy_now)
energy_full=$(cat /sys/class/power_supply/BAT${bat}/energy_full)
percent=$(bc <<< "${energy_now} * 100 / ${energy_full}")

voltage_now=$(cat /sys/class/power_supply/BAT${bat}/voltage_now)
voltage_avg=$(bc <<< "scale=2; ${voltage_now} / 3000000")

if [ -z "${percent}" ]; then
    echo "{}"
    exit 1
fi

declare -A output

# Full text, state
if [ "${charge_status}" = "Discharging" ]; then
    output[text]="BATT ${percent}% ${voltage_avg}V"

    if [ ${percent} -gt ${charge_stop_thresh} ]; then
        output[state]="Warning"
    elif [ ${percent} -ge ${charge_start_thresh} ]; then
        output[state]="Good"
    elif [ ${percent} -ge 35 ]; then
        output[state]="Idle"
    elif [ ${percent} -ge 20 ]; then
        output[state]="Warning"
    else
        output[state]="Critical"
    fi
elif [ "${charge_status}" = "Charging" ]; then
    output[text]="CHRG ${percent}% ${voltage_avg}V"

    if [ ${percent} -gt ${charge_stop_thresh} ]; then
        output[state]="Warning"
    elif [ ${percent} -ge ${charge_start_thresh} ]; then
        output[state]="Info"
    elif [ ${percent} -ge 40 ]; then
        output[state]="Good"
    fi
else
    # Plugged in; not charging
    output[text]="HOLD ${percent}% ${voltage_avg}V"

    if [ ${percent} -gt ${charge_stop_thresh} ]; then
        output[state]="Info"
    elif [ ${percent} -ge ${charge_start_thresh} ]; then
        output[state]="Idle"
    else
        output[state]="Warning"
    fi
fi

# Output
keys=("${!output[@]}")
echo "{"
for k in "${keys[@]:0:${#keys[@]}-1}"; do
    echo "\"$k\": \"${output[$k]}\","
done
echo "\"${keys[-1]}\": \"${output[${keys[-1]}]}\""
echo "}"
