#!/bin/bash

# https://stackoverflow.com/a/64182793
freq=$(awk '
length==6 {
    printf("%.0f%s\n", $0/10^3, "MHz"); next
} length==7 {
    printf("%.1f%s\n", $0/10^6, "GHz")
}' /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
)

if [ -z "${freq}" ]; then
    echo "{}"
    exit 1
fi

declare -A output

# Full text
output[text]="${freq}"

# Output
keys=("${!output[@]}")
echo "{"
for k in "${keys[@]:0:${#keys[@]}-1}"; do
    echo "\"$k\": \"${output[$k]}\","
done
echo "\"${keys[-1]}\": \"${output[${keys[-1]}]}\""
echo "}"
