#!/bin/bash

chip=${1:-thinkad-isa-0000}
t_warn=${2:-60}
t_crit=${3:-75}

# Get chip temperature
temperature=$(sensors -u "${chip}" 2>/dev/null | awk '/temp1_input/ {printf("%d", $2)}')

if [ -z "${temperature}" ]; then
    exit 0
fi

declare -A output

# Full text
output[full_text]="${temperature}°C"

# Color
if [ "${temperature}" -ge "${t_crit}" ]; then
    output[color]="#FF0000"
elif [ "${temperature}" -ge "${t_warn}" ]; then
    output[color]="#FFFF00"
fi

# Output
echo "{"
for k in "${!output[@]}"; do
    echo "\"$k\": \"${output[$k]}\""
done
echo "}"
