#!/bin/bash

# My top level bar which has some cool stuff in it
# run it as script | lemonbar

#get_music() {
#    MUSICICON=$(printf '\uf1bc')
#    SONG=`spotify-control.py metadata`
#
#    if [[ $SONG == "no spotify" ]]; then
#        MUSICICON=''
#        SONG='Spotify not running'
#    fi;
#
#    echo -n "$MUSICICON $SONG"
#}

get_time() {
    DATEICON=$(printf '\uf017')
    DATE=$(date "+%a %d.%m.%Y %H:%M")

    echo -n "$DATEICON $DATE"
}

get_volume() {
    VOL=`amixer get Master | grep 'Front Left:' | awk '{print substr($5,2,length($5)-3)}'`
    HP=`pactl list sinks | grep 'Active Port:' | awk '{print $3}'`
    MUTE_STATUS=`pactl list sinks | grep 'Mute:' | awk '{print $2}'`

    if [ "yes" == $MUTE_STATUS ]; then
        VOLICON=$(printf '\uf026')
    elif [[ VOL -ge "50" ]]; then
        VOLICON=$(printf '\uf028')
    else
        VOLICON=$(printf '\uf027')
    fi

    if [ "analog-output-headphones" == $HP ]; then
        HP=$(printf ' \uf025')
    else
        HP=''
    fi

    echo -n "$VOLICON $VOL%$HP"
}

get_battery() {
    BATPERC=`acpi --battery | awk '{gsub(/,/,""); print $4}' | sed 's/%//'`
    BATSTAT=`acpi --battery | awk '{gsub(/,/,""); print $3}'`

    if [[ $BATPERC -gt "90" ]]; then
        BATICON=$(printf '\uf240')
    elif [[ $BATPERC -gt "70" ]]; then
        BATICON=$(printf '\uf241')
    elif [[ $BATPERC -gt "50" ]]; then
        BATICON=$(printf '\uf242')
    elif [[ $BATPERC -gt "10" ]]; then
        BATICON=$(printf '\uf243')
    else
        BATICON=$(printf '\uf244')
    fi

    CHARG=""

    if [[ $BATSTAT == "Charging" ]]; then
        CHARG="$(printf ' \uf0e7')"
    fi

    TESTTT=$(printf '\uf240 \uf241 \uf242 \uf243 \uf244')
    echo -n "$BATICON $BATPERC%$CHARG"
}

get_wifi() {
    ESSID=$(/sbin/iwconfig wlp58s0 | grep ESSID | awk -F: '{gsub(/"/,""); print $2}' | sed -e 's/[[:space:]]*$//')

    if [[ $ESSID != 'off/any' ]]; then
        WISTATUS=$(/sbin/iwconfig wlp58s0 | grep Link | awk '{gsub(/Quality=/,""); print $2}' | awk -F/ '{print $1}')
        WISTATUS=" ($WISTATUS)"
    else
        ESSID='off'
    fi

    WIICON=$(printf '\uf1eb')

#    if [[ $WISTATUS -gt 50 ]]; then
#        WIICON=$(printf '\uf1eb')
#    elif [[ $WISTATUS -gt 30 ]]; then
#        WIICON=$(printf '\uf1eb')
#    else
#        WIICON=$(printf '\uf1eb')
#    fi

    echo -n "$WIICON $ESSID$WISTATUS"
}

while :
do
    output="%{l}$(get_music) %{c}$(get_time) %{r}$(get_wifi) | $(get_volume) | $(get_battery)"

    # List of all the monitors/screens you have in your setup
    Monitors=$(xrandr | grep -o "^.* connected" | sed "s/ connected//")
    tmp=0
    barout=""
    for m in $(echo "$Monitors"); do
            barout+="%{S${tmp}}$output"
                let tmp=$tmp+1
            done
    echo $barout
    sleep 2
done
