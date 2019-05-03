#!/bin/bash
###############################################################################
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You can receive a copy of the GNU General Public License
# at <http://www.gnu.org/licenses/>.
###############################################################################

# Simple script that save your window arrangement when external display
# connected. The windows are rearranged on display disconnect to
# the remaining display. When the external display is reconnected
# you can use the script to restore windows arrangement.
# Created by dosmanak.

STORFILE="$(dirname $(realpath ./$0))/saved.wmctrl"


if [ "$1" == "save" ]; then
  rm $STORFILE
  wmctrl -l -G |while read window_id desktop_id x_offset y_offset width height junk; do
    offset=($(xwininfo -id $window_id |grep Relative | awk '{print $NF}'|xargs))
    # Although I tried to get precise position using xwininfo, I had to subtract
    # 15px from y position (Mint Cinnamon). May differ on your window manager.
    echo $window_id $desktop_id $((${x_offset}-${offset[0]})) \
      $((${y_offset}-15-${offset[1]}-${offset[0]})) $width $height $junk >> $STORFILE
  done

elif [ "$1" == "restore" ]; then
  while read window_id desktop_id x_offset y_offset width height junk; do 
    wmctrl -v -i -r $window_id -e 0,$x_offset,$y_offset,$width,$height 2>/dev/null
  done < $STORFILE
else
  echo "Missing argument. Usage:"
  echo "    $0 <save|restore>"
  exit 127
fi

