#!/bin/bash

chip=${1:-thinkad-isa-0000}
t_info=${2:-60}
t_warn=${3:-75}

# Get chip temperature
temperature=$(sensors -u "${chip}" 2>/dev/null | awk '/temp1_input/ {printf("%d", $2)}')

if [ -z "${temperature}" ]; then
    echo "{}"
    exit 1
fi

declare -A output

# Full text
output[text]="${temperature}°C"

# State
if [ "${temperature}" -ge "${t_warn}" ]; then
    output[state]="Warning"
elif [ "${temperature}" -ge "${t_info}" ]; then
    output[state]="Info"
fi

# Output
keys=("${!output[@]}")
echo "{"
for k in "${keys[@]:0:${#keys[@]}-1}"; do
    echo "\"$k\": \"${output[$k]}\","
done
echo "\"${keys[-1]}\": \"${output[${keys[-1]}]}\""
echo "}"
