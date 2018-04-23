#!/bin/bash

case $1 in
    select)
        sleep 0.4; scrot -sz /home/bfiedler/screenshots/current_screenshot.png
        ;;
    full)
        scrot -q 100 -mz /home/bfiedler/screenshots/current_screenshot.png
        ;;
    *)
        echo 'error, unknown argument. usage: screenshot.sh [select | full]'
        ;;
esac

xclip -selection clipboard -t image/png /home/bfiedler/screenshots/current_screenshot.png
