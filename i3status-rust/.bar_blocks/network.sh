#!/bin/bash
# From acleverpun on github

# Shows ip address of a given interface
#
# @param {String} interface: The network interface to check

interface_pattern="${1:-enp*}"
net_path=/sys/class/net
interface_path=$(echo ${net_path}/${interface_pattern})
# Expand wildcard interfaces
interface=${interface_path#${net_path}/}

state="$(cat ${interface_path}/operstate)"

if [[ ${state} != "up" ]]; then
    echo "{}"
    exit 1
fi

declare -A output

ipaddr=$(ip addr show ${interface} | awk 'match($0, "inet (.+)/", groups) {print groups[1]}')

if [[ ${interface_pattern} == "wlan*" ]]; then
    quality=$(grep ${interface} /proc/net/wireless | awk '{print int($3 * 100 / 70)}')
    ssid="$(iw ${interface} link | grep SSID | cut -d ' ' -f 2)"
    IFS=' ' read -r down up <<< $(\
        iw ${interface} link \
        | grep bitrate \
        | cut -d " " -f 3 \
        | paste -sd " " \
    )
    speed=$(printf "%.0f↓ %.0f↑" "${down}" "${up}")
    text="${quality}% ${speed} Mb/s (${ssid})"
    label="W:"
elif [[ ${interface_pattern} == "enp*" ]]; then
    quality=100
    speed=$(cat ${interface_path}/speed)
    text="${speed} Mb/s"
    label="E:"
else
    echo "{}"
    exit 1
fi

# Full text
output[text]="${label} ${text}"

# State
if [[ -z "${ipaddr}" ]]; then
    output[state]="Warning"
elif [[ ${quality} -ge 80 ]]; then
    output[state]="Good"
elif [[ ${quality} -ge 40 ]]; then
    output[state]="Idle"
else
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
