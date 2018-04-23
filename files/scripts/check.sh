#!/bin/bash

if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
    echo 'not enough arguments provided - please provide pname ifthere ifnot'
    exit 1
fi

pid=`pidof $1`

if [[ -z "$pid" ]]; then
    echo "$3"
else
    echo "$2"
fi
