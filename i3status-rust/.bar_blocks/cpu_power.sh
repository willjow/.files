#!/bin/bash

time_diff=$1
info_threshold=${2:-15}
warning_threshold=${3:-30}

cur_uj=$(cat /sys/class/powercap/intel-rapl:0/energy_uj)
prev_uj_file=/run/user/$(id -u)/i3blocks-cpu_power-prev_cpu_uj
prev_uj=$(cat ${prev_uj_file})
echo ${cur_uj} > ${prev_uj_file}

watts_raw=$(bc <<< "scale=2; (${cur_uj}-${prev_uj})/(${time_diff}*1000000)")
watts_int=$(printf "%.0f" ${watts_raw})

if [ -z "${watts_raw}" ]; then
    echo "{}"
    exit 1
fi

declare -A output

if [[ ${watts_int} -lt 10 ]]; then
    watts=$(printf "%.2f" "${watts_raw}")
else
    watts=$(printf "%.1f" "${watts_raw}")
fi

# Full text
output[text]="CPU ${watts}W"

# State
if [[ ${watts_int} -ge ${info_threshold} ]]; then
    output[state]="Info"
elif [[ ${watts_int} -ge ${warning_threshold} ]]; then
    output[state]="Warning"
fi

# Output
keys=("${!output[@]}")
echo "{"
for k in "${keys[@]:0:${#keys[@]}-1}"; do
    echo "\"$k\": \"${output[$k]}\","
done
echo "\"${keys[-1]}\": \"${output[${keys[-1]}]}\""
echo "}"
