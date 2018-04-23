#!/bin/bash

~/.bin/connectivity.sh

if [[ $? == "0" ]]; then
    exec $1
fi
