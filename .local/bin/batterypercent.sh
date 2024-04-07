#!/bin/env bash

# Battery script for i3blocks with nerdfont

ICONS_DISCHARGING=(󱃍 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)
ICONS_CHARGING=(󰢟 󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅)

ACPI=`acpi -ab`
CHARGING=`echo "$ACPI" | grep -o on-line`
CHARGE=`echo "$ACPI" | grep -E "[0-9]{1,3}%" -o`
CHARGE=${CHARGE%?}

for PERCENT in `seq 100 -10 0`; do
  if [ $CHARGE -ge $PERCENT ]; then
    ICON_IDX=$(($PERCENT / 10))

    ICON=ICONS_CHARGING[$ICON_IDX]  
    if [ -z $CHARGING ]; then
      ICON=ICONS_DISCHARGING[$ICON_IDX]  
    fi
    
    TEXT="${!ICON} $CHARGE%"
    
    if [ $CHARGE -le 20 ]; then
        COLOR="#FF8000"                  
    else
        COLOR="#FFFFFF"
    fi

    if [ $CHARGE -le 10 ]; then
        URGENT="true"                  
    else
        URGENT="false"                  
    fi

    printf '{"full_text": "%s", "color": "%s", "urgent": "%s"}\n' "$TEXT" "$COLOR" "$URGENT"
    break
  fi
done

ALARM_LOCK="/tmp/sb-bat.lock"
ALARM="/usr/share/sounds/freedesktop/stereo/suspend-error.oga"

if [ -z $CHARGING  ] && [ "$CHARGE" -le 10 ]; then
	if  [ ! -f "$ALARM_LOCK" ]; then
		mpv --volume=60 --no-video "$ALARM" >/dev/null 2>&1 &
		touch "$ALARM_LOCK"
		notify-send "Battery low!" -h string:x-dunst-stack-tag:battery -i battery-level-10-symbolic
	fi

  if [ "$CHARGE" -le 5 ]; then
    systemctl suspend
  fi

else
	rm -f "$ALARM_LOCK"
fi
