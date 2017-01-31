#!/bin/bash
# http://askubuntu.com/questions/107277/how-do-i-switch-to-another-audio-output-sink-in-xfce

SINK=`pactl list sinks short | grep alsa-card | cut -f 1`
INPUTS=`pactl list sink-inputs short | cut -f 1`
for i in $INPUTS; do
        echo "Verschiebe in $i nach $SINK"
        pactl move-sink-input $i $SINK
done