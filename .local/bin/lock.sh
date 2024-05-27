#!/usr/bin/env bash

# based on https://michaelabrahamsen.com/posts/custom-lockscreen-i3lock/

# forcibly switch layout to English to remove guesswork when entering password
# 'xkb-switch -s us' breaks all other layouts, so cycle between them instead
layout=`xkb-switch`
while [ $layout != "us" ]
    do
        xkb-switch -n
        layout=`xkb-switch` 
    done

# set the icon and a temporary location for the screenshot to be stored
icon="$HOME/Images/flaticon.com-creative-stall-premium-lock.png"
tmpbg='/tmp/screen.png'

# take a screenshot
xfce4-screenshooter -f -s "$tmpbg"

# blur the screenshot by resizing and scaling back up
magick "$tmpbg" -filter Gaussian -thumbnail 10% -sample 1000% "$tmpbg"

# overlay the icon onto the screenshot
magick "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

# lock the screen with the blurred screenshot
i3lock -i "$tmpbg"

