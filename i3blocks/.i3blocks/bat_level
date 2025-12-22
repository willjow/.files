#!/bin/bash

bat=${BLOCK_INSTANCE:-0}

charge_status=$(cat /sys/class/power_supply/BAT${bat}/status)

energy_now=$(cat /sys/class/power_supply/BAT${bat}/energy_now)
energy_full=$(cat /sys/class/power_supply/BAT${bat}/energy_full)
percent=$(bc <<< "${energy_now} * 100 / ${energy_full}")

voltage_now=$(cat /sys/class/power_supply/BAT${bat}/voltage_now)
voltage_avg=$(bc <<< "scale=2; ${voltage_now} / 3000000")

if [ -z "${percent}" ]; then
  exit 1
fi

declare -A output

# Urgent
output[urgent]="false"

# Full text, color
if [ "${charge_status}" = "Discharging" ]; then
  output[full_text]="BATT ${percent}% ${voltage_avg}V"

  if [ ${percent} -ge 80 ]; then
    output[color]="#FF00FF"
  elif [ ${percent} -ge 64 ]; then
    output[color]="#00FF00"
  elif [ ${percent} -ge 40 ]; then
    :
  elif [ ${percent} -ge 30 ]; then
    output[color]="#FFFF00"
  elif [ ${percent} -ge 20 ]; then
    output[color]="#FF0000"
  else
    output[urgent]="true"
  fi
elif [ "${charge_status}" = "Charging" ]; then
  output[full_text]="CHRG ${percent}% ${voltage_avg}V"

  if [ ${percent} -ge 80 ]; then
    output[color]="#FF00FF"
  elif [ ${percent} -ge 64 ]; then
    output[color]="#4AA5FF"
  elif [ ${percent} -ge 40 ]; then
    output[color]="#00FF00"
  fi
else
  output[full_text]="HOLD ${percent}% ${voltage_avg}V"
fi

# Output
echo "{"
for k in "${!output[@]}"; do
    echo "\"$k\": \"${output[$k]}\""
done
echo "}"
