cmd=$1
pwr_file="/sys/class/backlight/intel_backlight/brightness"
pwr=$(cat ${pwr_file})

set_pwr() {
  echo $1 > ${pwr_file}
}

lo_steps=(1 46 91 181 271 406 586)
hi_steps=$(seq 849 263 4794)
steps=(${lo_steps[*]} ${hi_steps[*]})

i=0
while (( ${pwr} > ${steps[$i]} )); do
  i=$(($i + 1))
done

if [ ${cmd} = "inc" ]; then
  if (( $i < 4794 )); then
    set_pwr ${steps[$(($i + 1))]}
  fi
elif  [ ${cmd} = "dec" ]; then
  if (( $i > 0 )); then
    set_pwr ${steps[$(($i - 1))]}
  fi
fi

