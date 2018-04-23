#!/bin/bash

# Outputs the current volume
# as bar [xxxxxxxxxx] where x
# is filled from left to right with /

#CURSINK=`pactl list sinks short | grep RUNNING | egrep -o '^[0-9]+'`
CURVOL=`pactl list sinks | grep -i '^\svolume' | egrep -o '[0-9]+' | head -1`
MUTE=`pactl list sinks | grep -i '^\smute' | egrep -o '[a-z]+$' | head -1`

numbars=$(($CURVOL / 9000))
numsign=$(($CURVOL % 9000))

case $numsign in
  0)    sgn='.';;
  3000) sgn='-';;
  6000) sgn='~';;
esac

case $numbars in
  0)  bar='['$sgn'.........]' ;;
  1)  bar='[/'$sgn'........]' ;;
  2)  bar='[//'$sgn'.......]' ;;
  3)  bar='[///'$sgn'......]' ;;
  4)  bar='[////'$sgn'.....]' ;;
  5)  bar='[/////'$sgn'....]' ;;
  6)  bar='[//////'$sgn'...]' ;;
  7)  bar='[///////'$sgn'..]' ;;
  8)  bar='[////////'$sgn'.]' ;;
  9)  bar='[/////////'$sgn']' ;;
  10) bar='[//////////]'      ;;
esac

if [ $MUTE = 'yes' ]; then
    bar='[  (mute)  ]'
fi

echo $bar
