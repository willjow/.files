#!/bin/bash

# First check if the gpu is active; otherwise `nvidia-smi` will wake it
runtime_status=$(cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status)
if [[ ! "$runtime_status" =~ active ]]; then
    gpu_status="off"
else
    nvidia_smi=$(nvidia-smi)
    power=$(rg '(\d+)W\s*\/\s*(\d+)W' -or '$1' <<< "${nvidia_smi}")
    temperature=$(rg '(\d+)C' -or '$1' <<< "${nvidia_smi}")
    gpu_status="${power}W ${temperature}°C"
fi

declare -A output

# Full text
output[full_text]="GPU ${gpu_status}"

# Output
echo "{"
for k in "${!output[@]}"; do
    echo "\"$k\": \"${output[$k]}\""
done
echo "}"
