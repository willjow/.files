#!/bin/sh

refresh()
{
    pkill -x -RTMIN+30 i3blocks
}

get_temp()
{
    busctl --user -- get-property rs.wl-gammarelay / rs.wl.gammarelay Temperature | cut -d ' ' -f 2
}

set_temp()
{
    busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q $1 > /dev/null
}

update_temp()
{
    busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n $1 > /dev/null
}

case $BLOCK_BUTTON in
    right)
        set_temp 6500 && refresh ;;
    wheel_up)
        update_temp 200 && refresh ;;
    wheel_down)
        update_temp -200 && refresh ;;
esac

temp=$(get_temp)

if [ -z "${temp}" ]; then
    echo "{}"
    exit 1
fi

declare -A output

# Full text
output[text]="CT ${temp}K"

# Output
keys=("${!output[@]}")
echo "{"
for k in "${keys[@]:0:${#keys[@]}-1}"; do
    echo "\"$k\": \"${output[$k]}\","
done
echo "\"${keys[-1]}\": \"${output[${keys[-1]}]}\""
echo "}"
