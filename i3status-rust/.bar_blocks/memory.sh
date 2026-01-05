#!/bin/bash
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

TYPE="${1:-mem}"
LOW_THRESH="${1:-25}" # color will turn yellow under this threshold (default: 25%)

IFS=' ' read -r usage state <<< $(awk -v type=$TYPE -v low_thresh=$LOW_THRESH '
/^MemTotal:/ {
    mem_total=$2
}
/^MemFree:/ {
    mem_free=$2
}
/^Buffers:/ {
    mem_free+=$2
}
/^Cached:/ {
    mem_free+=$2
}
/^SwapTotal:/ {
    swap_total=$2
}
/^SwapFree:/ {
    swap_free=$2
}
END {
    # usage
    if (type == "swap") {
        usage=sprintf("%.1fG", (swap_total-swap_free)/1024/1024)
    } else {
        usage=sprintf("%.1fG", mem_free/1024/1024)
    }

        # state (if less than LOW_THRESH percent)
        if ((mem_free / mem_total * 100) < (low_thresh + 0)) {
            state="Info"
        } else {
            state="Idle"
        }

    printf("%s %s", usage, state)
}
' /proc/meminfo
)

if [ -z "${usage}" ]; then
    echo "{}"
    exit 1
fi

declare -A output

# Full text
output[text]="RAM ${usage}"

if [ -n "${state}" ]; then
    output[state]="${state}"
fi

# Output
keys=("${!output[@]}")
echo "{"
for k in "${keys[@]:0:${#keys[@]}-1}"; do
    echo "\"$k\": \"${output[$k]}\","
done
echo "\"${keys[-1]}\": \"${output[${keys[-1]}]}\""
echo "}"
