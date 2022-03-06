#!/bin/sh

BACKLIGHT=`xbacklight -get`
STEP=1

if [ $1 = "-inc" ]; then
    xbacklight -inc $STEP
    exit 0
fi

if [ $1 = "-dec" ]; then
    if [ $((BACKLIGHT - STEP)) -le 1 ]; then
        xbacklight -set 1
    else
        xbacklight -dec $STEP
    fi
fi
