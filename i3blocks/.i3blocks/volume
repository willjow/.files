#!/bin/bash
volume_str=$(wpctl get-volume @DEFAULT_SINK@)
percent=$(awk '{print $2 * 100}' <<< ${volume_str})
muted=$(awk 'index($3, "MUTED")' <<< ${volume_str})
label=$([ "${muted}" ] && echo "MUTE" || echo "VOL")

declare -A output

# Full text
output[full_text]="${label} ${percent}%"

# Color
if [ -n "${muted}" ]; then
    output[color]="#FFFF00"
fi

# Output
echo "{"
for k in "${!output[@]}"; do
    echo "\"$k\": \"${output[$k]}\""
done
echo "}"
