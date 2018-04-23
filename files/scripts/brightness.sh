#!/bin/bash

ACTION=$1

set -e

BR_DIR='/sys/class/backlight/intel_backlight'

BRIGHTNESS=`cat $BR_DIR/brightness`
MAX_BRIGHTNESS=`cat $BR_DIR/max_brightness`
STEP=$(($MAX_BRIGHTNESS / 20))

if [[ $ACTION == "inc" ]]; then
    BRIGHTNESS=$(($BRIGHTNESS + $STEP))
fi

if [[ $ACTION == "dec" ]]; then
    BRIGHTNESS=$(($BRIGHTNESS - $STEP))
fi

if [[ $ACTION == "get" ]]; then
    echo $(($BRIGHTNESS * 100 / $MAX_BRIGHTNESS))
    exit 0
fi

if [[ $ACTION == "set" ]]; then
    BRIGHTNESS=$2
fi

if [[ $BRIGHTNESS -gt $MAX_BRIGHTNESS ]]; then
    BRIGHTNESS=$MAX_BRIGHTNESS
fi

if [[ $BRIGHTNESS -lt 10 ]]; then
    BRIGHTNESS=10
fi

echo $BRIGHTNESS > $BR_DIR/brightness
