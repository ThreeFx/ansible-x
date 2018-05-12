#!/bin/bash

sleep 1

trayer --align right --edge bottom --widthtype request --height 19 \
    --transparent true --tint 0x00000000 &

nm-applet &
