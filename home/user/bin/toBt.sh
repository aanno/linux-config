#!/bin/bash
# http://askubuntu.com/questions/107277/how-do-i-switch-to-another-audio-output-sink-in-xfce

OCHANNEL=`pactl list modules short | grep btheadset | cut -f 1`
for i in $OCHANNEL; do
        echo "altes module $i"
        pactl unload-module $i
done
CHANNEL=`pactl load-module module-alsa-sink device=btheadset`
echo "neues module $CHANNEL"
if [ $? -ne 0 ]; then
        echo "No bt connection"
        exit -1
fi

#CHANNEL=`pactl list modules short | grep module-bluetooth-device | cut -f 1`
#echo "neues module $CHANNEL"
#if [ $? -ne 0 ]; then
#        echo "No bt connection"
#        exit -1
#fi

SINK=`pactl list sinks short | grep btheadset | cut -f 1`
INPUTS=`pactl list sink-inputs short | cut -f 1`
for i in $INPUTS; do
        echo "Verschiebe in $i nach $SINK"
        pactl move-sink-input $i $SINK
done