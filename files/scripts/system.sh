#!/bin/bash

case "$1" in
    suspend)
        sudo /usr/sbin/pm-suspend
        /usr/local/bin/lock
        ;;
    hibernate)
        sudo /usr/sbin/pm-hibernate
        ;;
    reboot)
        rm ~/.xmonad/xmonad.state
        dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" \
        /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart
        ;;
    shutdown)
        rm ~/.xmonad/xmonad.state
        dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" \
        /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
        ;;
    *)
        echo "Command not found: $1"
        echo "Usage: $0 [ suspend | hibernate | reboot | shutdown ]"
        ;;
esac
