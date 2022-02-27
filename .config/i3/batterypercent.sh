#!/bin/sh

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

print() {
    echo ${!ICON} $CHARGE%
    exit 0
}

ICON=?

CHARGING=`acpi -b | grep -o Charging`
CHARGE=`acpi -b | grep -E "[0-9]{1,3}%" -o`
CHARGE=`echo $CHARGE | grep -E "[0-9]{1,3}" -o`

for PERCENT in `seq 100 -10 0`; do
    if [ $CHARGE -ge $PERCENT ]; then
        ICON="CHARGE_$PERCENT"
        if [ -z $CHARGING ]; then
            ICON="DIS$ICON"
        fi
        print
    fi
done
