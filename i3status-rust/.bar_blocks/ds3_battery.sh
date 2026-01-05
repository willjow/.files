#!/bin/bash

capacity_path="/sys/class/power_supply/sony_controller_battery_*/capacity"
if [ -f $capacity_path ]; then
    capacity="$(cat $capacity_path)%"
else
    echo "{}"
    exit 1
fi

declare -A output

# Full text
output[text]="DS3 ${capacity}"

# Output
keys=("${!output[@]}")
echo "{"
for k in "${keys[@]:0:${#keys[@]}-1}"; do
    echo "\"$k\": \"${output[$k]}\","
done
echo "\"${keys[-1]}\": \"${output[${keys[-1]}]}\""
echo "}"
