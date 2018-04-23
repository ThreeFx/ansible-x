#!/bin/bash

DEFAULT='lock'
#BLANK='i3lock -nc 000000'

PID=`pgrep xautolock`

case $1 in
    enable-autolock)
        if [[ $PID == "" ]]; then
            xautolock -detectsleep -locker "$DEFAULT" -time 5 &
        else
            echo 'xautolock already running!'
        fi
        ;;
    disable-autolock)
        if [[ $PID != "" ]]; then
            killall xautolock
        else
            echo 'xautolock not running!'
        fi
        ;;
    default)
        if [[ $PID == "" ]]; then
            `$DEFAULT`
        else
            xautolock -locknow
        fi
        ;;
#    blank)
#        if [[ $PID == "" ]]; then
#            i3lock -uc 000000
#        else
#            $0 disable-autolock
#            $0 blank
#            $0 enable-autolock
#        fi
#        ;;
    statusfancy)
        if [[ $PID == "" ]]; then
            echo "%{u#c16772 F#16772}  %{-u F-}"
        else
            echo "%{u#98FB98 F#98FB98}  %{-u F-}"
        fi
        ;;
    *)
        echo "Command not found: $1"
        echo "Usage: $0 [ enable-autolock | disable-autolock | default ]"
        ;;
esac
