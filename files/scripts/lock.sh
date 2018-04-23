#!/bin/bash

pkill -STOP notification-da

i3lock --nofork --clock --indicator \
    --blur=0.001 \
    --insidevercolor=ffffff00 \
    --insidewrongcolor=ffffff00 \
    --insidecolor=ffffff00 \
    --ringvercolor=aaaaaaff \
    --ringwrongcolor=aaaaaaff \
    --ringcolor=aaaaaaff \
    --linecolor=ffffff77 \
    --separatorcolor=00000000 \
    --textcolor=ffffff77 \
    --keyhlcolor=555555ff \
    --bshlcolor=555555ff \
    --line-uses-inside \
    --timesize=20 \
    --indpos="x+(w/32):y+(30*h/32)" \
    --radius=20 \
    --timepos="ix-4.1*r:iy-5*r" \
    --timecolor=aaaaaaff \
    --datestr="%A, %d. %b %Y" \
    --datepos="tx:ty+17" \
    --datecolor=aaaaaaff \
    --veriftext="" \
    --wrongtext="" \
    --modsize="8"

pkill -CONT notification-da
#pkill notification-da
