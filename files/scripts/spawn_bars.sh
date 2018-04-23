#!/bin/bash

killall -9 polybar

for mon in `xrandr | grep -iv disconnected | grep connected | cut -d ' ' -f 1`; do
    MONITOR=$mon polybar -c /home/bfiedler/.dotfiles/polybar/config top &
    MONITOR=$mon polybar -c /home/bfiedler/.dotfiles/polybar/config bottom &
done
