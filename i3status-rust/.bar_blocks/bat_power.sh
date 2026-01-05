#!/bin/bash

bat=${BLOCK_INSTANCE:-0}
threshold=14
precision=2

charge_status=$(cat /sys/class/power_supply/BAT${bat}/status)

pow_now=$(cat /sys/class/power_supply/BAT${bat}/power_now)
watts=$(bc <<< "scale=${precision}; ${pow_now} / 1000000")
watts_int=$(echo ${watts} | awk -F '.' '{print $1}')

if [ -z "${watts}" ]; then
    echo "{}"
    exit 1
fi

declare -A output

# Full text
output[text]="${watts}W"

# State
if [ "${charge_status}" = "Charging" ]; then
    output[state]="Good"
elif [ "${charge_status}" = "Discharging" ]; then
    if [ ${watts_int} -ge ${threshold} ]; then
        output[info]="Info"
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
