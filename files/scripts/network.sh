#!/bin/sh

wifi='wlp58s0'
hardwired='eth0'

if [ "$1" = '-ip' ]; then
    ip=`ip route get 8.8.8.8 | grep -o 'src\s*.*\s' | egrep -o '[0-9]+.[0-9]+.[0-9]+.[0-9]+'`
    if [ -z $ip ]; then
        ip='no ip'
    fi
    echo $ip
    exit 0
fi

if [ -e /sys/class/net/$hardwired/carrier ]
  then
    echo 'wired'
    exit 0
fi

#iw dev $wifi link 2>&1 | grep -q no\ wireless\ extensions\. && {
#    echo 'no wifi iface'
#    exit 0
#}

essid=`/sbin/iw dev $wifi link | grep SSID | awk -F ':' '{print $2}' | cut -c 2-`
#stngth=`/sbin/iwconfig $wifi | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 1`
#bars=`expr $stngth / 10`
#
#case $bars in
#    0|1)  bar='[/----]' ;;
#    2|3)  bar='[//---]' ;;
#    4|5)  bar='[///--]' ;;
#    6|7)  bar='[////-]' ;;
#    8|9)  bar='[/////]' ;;
#    10)   bar='[/////]' ;;
#    *)    bar='[- x -]' ;;
#esac

#if [ -z "$essid" ]; then
#    essid='no wifi'
#fi
#
#if [ "$1" = '-s' ]; then
#    essid=''
#fi
#
#if [ "$1" = '-n' ]; then
#    bar=''
#fi

#echo $essid $bar

echo $essid

exit 0
