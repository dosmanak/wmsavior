#!/bin/bash

#window_id desktop_id x_offset y_offset width height junk
# The next column always contains the client machine name. 
# The remainder of the line contains the window title (possibly with multiple spaces in the title).


if [ "$1" == "save" ]; then
  rm saved.wmctrl
  wmctrl -l -G |while read window_id desktop_id x_offset y_offset width height junk; do
    offset=($(xwininfo -id $window_id |grep Relative | awk '{print $NF}'|xargs))
    echo ${offset[0]} ${offset[1]}
    echo $window_id $desktop_id $((${x_offset}-${offset[0]})) $((${y_offset}-15-${offset[1]}-${offset[0]})) $width $height $junk >> saved.wmctrl
  done

elif [ "$1" == "restore" ]; then
  while read window_id desktop_id x_offset y_offset width height junk; do 
    wmctrl -v -i -r $window_id -e 0,$x_offset,$y_offset,$width,$height
  done < saved.wmctrl
else
  echo "BAD ARGUMENT pyco!"
fi

