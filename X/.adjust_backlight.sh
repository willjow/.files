cmd=$1
pwr=$(cat /sys/class/backlight/intel_backlight/brightness)

if [ ${cmd} = "inc" ]; then
  if [ ${pwr} -le 1 ]; then
    xbacklight -set 1
  elif [ ${pwr} -lt 48 ]; then
    xbacklight -set 2
  elif [ ${pwr} -lt 96 ]; then
    xbacklight -set 4
  elif [ ${pwr} -lt 192 ]; then
    xbacklight -set 6
  elif [ ${pwr}-lt 600 ]; then
    xbacklight -set 12
  else
    xbacklight -inc 6
  fi
elif  [ ${cmd} = "dec" ]; then
  if [ ${pwr} -le 48 ]; then
    xbacklight -set 0.02
  elif [ ${pwr} -le 96 ]; then
    xbacklight -set 1
  elif [ ${pwr} -le 192 ]; then
    xbacklight -set 2
  elif [ ${pwr} -le 288 ]; then
    xbacklight -set 4
  elif [ ${pwr}-le 600 ]; then
    xbacklight -set 6
  else
    xbacklight -dec 6
  fi
fi
