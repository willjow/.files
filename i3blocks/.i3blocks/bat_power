#!/bin/bash

bat=${BLOCK_INSTANCE:-0}
threshold=14
precision=2

charge_status=$(cat /sys/class/power_supply/BAT${bat}/status)

pow_now=$(cat /sys/class/power_supply/BAT${bat}/power_now)
watts=$(bc <<< "scale=${precision}; ${pow_now} / 1000000")
watts_int=$(echo ${watts} | awk -F '.' '{print $1}')

if [ -z "${watts}" ]; then
  exit 1
fi

declare -A output

# Full text
output[full_text]="${watts}W"

# Color
if [ "${charge_status}" = "Charging" ]; then
  output[color]="#FF00FF"
elif [ "${charge_status}" = "Discharging" ]; then
  if [ ${watts_int} -ge ${threshold} ]; then
    output[color]="#FFFF00"
  fi
fi

# Output
echo "{"
for k in "${!output[@]}"; do
    echo "\"$k\": \"${output[$k]}\""
done
echo "}"
