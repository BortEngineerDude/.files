#!/bin/sh

#Battery script for i3blocks with nerdfont

DISCHARGE_0=
DISCHARGE_10=
DISCHARGE_20=
DISCHARGE_30=
DISCHARGE_40=
DISCHARGE_50=
DISCHARGE_60=
DISCHARGE_70=
DISCHARGE_80=
DISCHARGE_90=
DISCHARGE_100=

CHARGE_0=
CHARGE_10=
CHARGE_20=
CHARGE_30=
CHARGE_40=
CHARGE_50=
CHARGE_60=
CHARGE_70=
CHARGE_80=
CHARGE_90=
CHARGE_100=

ACPI=`acpi -b`
CHARGING=`echo $ACPI | grep -o Charging`
CHARGE=`echo $ACPI | grep -E "[0-9]{1,3}%" -o`
CHARGE=${CHARGE%?}

for PERCENT in `seq 100 -10 0`; do
    if [ $CHARGE -ge $PERCENT ]; then
        ICON="CHARGE_$PERCENT"
        if [ -z $CHARGING ]; then
            ICON="DIS$ICON"
        fi
        
        TEXT="${!ICON} $CHARGE%"
        
        if [ $CHARGE -le 20 ]; then
            COLOR="#FF8000"                  
        else
            COLOR="#FFFFFF"
        fi

        if [ $CHARGE -le 5 ]; then
            URGENT="true"                  
        else
            URGENT="false"                  
        fi

        printf '{"full_text": "%s", "color": "%s", "urgent": "%s"}\n' "$TEXT" "$COLOR" "$URGENT"
        exit
    fi
done
