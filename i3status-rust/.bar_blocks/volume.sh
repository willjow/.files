#!/bin/bash
volume_str=$(wpctl get-volume @DEFAULT_SINK@)
percent=$(awk '{print $2 * 100}' <<< ${volume_str})
muted=$(awk 'index($3, "MUTED")' <<< ${volume_str})
label=$([ "${muted}" ] && echo "MUTE" || echo "VOL")

declare -A output

# Full text
output[text]="${label} ${percent}%"

# State
if [ -n "${muted}" ]; then
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
