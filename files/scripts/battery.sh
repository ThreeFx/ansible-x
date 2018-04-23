#!/bin/bash

set -e

# fix me

bat_status=`acpi | grep -i battery`

perc=`echo $bat_status | awk -F '%' '{print $1}' | awk -F ' ' '{print $4}'`

#echo 'DEBUG: '$perc

#def='\[\033[0m\]'
#red='\[\033[1;31m\]'
#green='\[\033[38;5;2m\]'
#yellow='\[\033[38;5;11m\]'
#blue='\[\033[1;34m\]'
#skyblue='\[\033[1;36m\]'
#darkred='\[\033[38;5;1m\]'
#
#col=$def
#
#if [ $perc <= 15 ]; then
#    col=$orange
#elif [ $perc <= 10 ]; then
#    col=$red
#fi

stat=''
echo $bat_status | grep -q Full && {
    stat='full'
    col=$green
}

echo $bat_status | grep -q Charging && {
    stat=`echo $bat_status | awk -F ' ' '{print $6}'`' to full'
    col=$yellow
}

echo $bat_status | grep -q Discharging && {
    stat=`acpi | awk -F ' ' '{print $6}'`' remain'
}

#case $bars in
#    0)  bar='[-----]' ;;
#    1)  bar='[/----]' ;;
#    2)  bar='[//---]' ;;
#    3)  bar='[///--]' ;;
#    4)  bar='[////-]' ;;
#    5)  bar='[/////]' ;;
#    *)  bar='[--x--]' ;;
#esac
#
#echo $stat $bar '('$perc'%)'

echo $perc

exit 0
