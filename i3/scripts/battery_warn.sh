#!/bin/bash

BAT="/org/freedesktop/UPower/devices/battery_BAT0"

LAST=100

while true; do

    STATE=$(upower -i $BAT | awk '/state/ {print $2}')
    if [ "$STATE" = "discharging" ]; then
        PERCENT=$(upower -i $BAT | grep percentage | awk '{print $2}' | tr -d '%')

        if [ "$PERCENT" -le 20 ] && [ "$LAST" -gt 20 ]; then
            notify-send -u normal -t 20000 "Battery low" "Battery at 20%"
        fi

        if [ "$PERCENT" -le 10 ] && [ "$LAST" -gt 10 ]; then
            notify-send -u normal -t 20000 "Battery very low" "Battery at 10%"
        fi

        if [ "$PERCENT" -le 5 ] && [ "$LAST" -gt 5 ]; then
            notify-send -u normal -t 20000 "Battery Critical" "Battery at 5%"
        fi

        LAST=$PERCENT
        sleep 30
    fi
done
