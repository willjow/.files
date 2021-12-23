#!/bin/bash
cmd=$1
pwr_file="/sys/class/backlight/intel_backlight/brightness"
pwr=$(cat ${pwr_file})

min_pwr=0
max_pwr=4794
lo_steps=(0 1 23 46 69 91 136 181 226 271 361 451 586 721 901 1081 1306)
hi_steps=$(seq 1527 297 4794)
steps=(${lo_steps[@]} ${hi_steps[@]})


set_pwr() {
  echo $1 > ${pwr_file}
}


i=0
while (( ${pwr} > ${steps[$i]} )); do
  i=$(($i + 1))
done

if [ ${cmd} = "inc" ]; then
  if (( $i < ${#steps[@]} )); then
    set_pwr ${steps[$(($i + 1))]}
  else
    set_pwr ${max_pwr}
  fi
elif  [ ${cmd} = "dec" ]; then
  if (( $i > 0 )); then
    set_pwr ${steps[$(($i - 1))]}
  else
    set_pwr ${min_pwr}
  fi
fi

