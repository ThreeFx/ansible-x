#!/bin/bash

PID=`pgrep redshift | wc -l`

#echo $PID

case $1 in
    statusfancy)
        if [[ $PID -le 2 ]]; then
            echo "%{u#ffffff F#8a7f8f}  %{-u F-}"
        else
            echo "%{u#c16772 F#16772}  %{-u F-}"
        fi
        ;;
    *)
        echo 'error'
esac
