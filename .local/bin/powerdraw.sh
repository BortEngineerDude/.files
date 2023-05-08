#!/bin/sh

while [ true ]; do
    echo - | awk "{printf \"%.1f\", $(($(cat /sys/class/power_supply/BAT0/power_now) / 1000000))}" ; echo " W "
    sleep 1
done
