#!/bin/bash

cur_uj=$(cat /sys/class/powercap/intel-rapl:0/energy_uj)
prev_uj_file=/run/user/$(id -u)/i3blocks-cpu_power-prev_cpu_uj
prev_uj=$(cat ${prev_uj_file})
echo ${cur_uj} > ${prev_uj_file}

time_diff=$1
watts_raw=$(bc <<< "scale=2; (${cur_uj}-${prev_uj})/(${time_diff}*1000000)")
watts_int=$(printf "%.0f" ${watts_raw})

if [ -z "${watts_raw}" ]; then
  exit 0
fi

declare -A output

if [[ ${watts_int} -lt 10 ]]; then
    watts=$(printf "%.2f" "${watts_raw}")
else
    watts=$(printf "%.1f" "${watts_raw}")
fi

# Full text
output[full_text]="CPU ${watts}W"

# Color
if [[ ${watts_int} -ge 15 ]]; then
    output[color]="#FFFF00"
elif [[ ${watts_int} -ge 30 ]]; then
    output[color]="#FF0000"
fi

# Output
echo "{"
for k in "${!output[@]}"; do
    echo "\"$k\": \"${output[$k]}\""
done
echo "}"
