#!/bin/sh
# set dpi for HiDPI display and extend non-HiDPI external display above HiDPI internal display

DPI=144
FACTOR=1.5

# turn disconnected outputs off
for screen in $(xrandr | grep disconnected | sed 's|^\([^ ]*\).*$|\1|g')
do
    xrandr --output $screen --off
done

EXT=`xrandr --current | sed 's/^\(.*\) connected.*$/\1/p;d' | grep -v ^eDP | head -n 1`
INT=`xrandr --current | sed 's/^\(.*\) connected.*$/\1/p;d' | grep -v ^DP | grep -v ^HDMI | head -n 1`

# set dpi
xrandr --dpi $DPI

if [ $EXT ]
then

    dim_int=`xrandr --current | grep -A 1 "^$INT connected" | head -n 2 | tail -n 1 | sed 's/^\s*\([0-9]*x[0-9]*\).*$/\1/'`
    dim_ext=`xrandr --current | grep -A 1 "^$EXT connected" | head -n 2 | tail -n 1 | sed 's/^\s*\([0-9]*x[0-9]*\).*$/\1/'`


    ext_w=`echo $dim_ext | cut -d x -f 1`
    ext_h=`echo $dim_ext | cut -d x -f 2`
    int_w=`echo $dim_int | cut -d x -f 1`
    int_h=`echo $dim_int | cut -d x -f 2`

    #echo $EXT ${ext_w}x${ext_h}
    #echo $INT ${int_w}x${int_h}

    ext_w=`echo "$ext_w*$FACTOR" | bc | sed 's/\..*$//'`
    ext_h=`echo "$ext_h*$FACTOR" | bc | sed 's/\..*$//'`

    #echo $EXT ${ext_w}x${ext_h}
    #echo $INT ${int_w}x${int_h}
    #echo 'xrandr --output '$INT' --primary --auto --pos '$ext_w'x0 --scale 1x1  --right-of '$EXT' --auto --scale '$FACTOR'x'$FACTOR' --pos 0x0'
    if [[ $1 = "ext" ]]; then
        xrandr --output "${EXT}" --primary --auto --scale ${FACTOR}x${FACTOR} --pos 0x0
        xrandr --output "${INT}" --auto --pos ${ext_w}x0 --scale 1x1
    else
        #xrandr --output "${INT}" --primary --auto --pos ${ext_w}x$(($ext_h - $int_h)) --scale 1x1
        xrandr --output "${INT}" --primary --auto --pos ${ext_w}x0 --scale 1x1
        xrandr --output "${EXT}" --auto --scale ${FACTOR}x${FACTOR} --pos 0x0
    fi
fi
