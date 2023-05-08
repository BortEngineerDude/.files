#!/bin/sh

#Volume script for i3blocks with nerdfont

VOLUME_0=󰕿
VOLUME_33=󰖀
VOLUME_66=󰕾
VOLUME_MUTE=󰝟

COLOR="NULL"
ICON="NULL"
VOLUME=`pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'`;
VOLUME=${VOLUME%?}
MUTE=`LC_ALL=C pactl get-sink-mute @DEFAULT_SINK@` 

if [ "$MUTE" = "Mute: yes" ]; then
    ICON=VOLUME_MUTE
    COLOR="#FF8000"
else
    COLOR="#FFFFFF"
    for PERCENT in `seq 0 33 66`; do
        if [ $PERCENT -le $VOLUME ]; then
            ICON=VOLUME_$PERCENT
        fi
    done
fi

TEXT="${!ICON} $VOLUME%"
printf '{"full_text": "%s", "color": "%s"}\n' "$TEXT" "$COLOR"
