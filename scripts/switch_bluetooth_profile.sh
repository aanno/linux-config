#!/bin/bash
# source: https://bbs.archlinux.org/viewtopic.php?pid=1973004
# prepare via enabling mSBC codec for HSP/HFP:
# https://wiki.archlinux.org/title/PipeWire#Low_audio_quality_on_Bluetooth
# the `bluez-monitor.conf` is located at:
# `/usr/share/pipewire/media-session.d/bluez-monitor.conf`
# note that the settings gui needs to be restarted after editing the file and calling
# `systemctl --user restart pipewire.service`

export LANG=C
export LC_ALL=C

msbc=`pactl list | grep Active | grep msbc`
a2dp=`pactl list | grep Active | grep a2dp-sink`
echo "Profiles:"
echo "msbc: $msbc"
echo "a2dp: $a2dp"
echo

card=`pactl list | grep "Name: bluez_card." | cut -d ' ' -f 2`
echo Card:
echo $card
echo

if [ -n "$a2dp" ]; then
    echo "Switching $card to msbc..."
    pactl set-card-profile $card headset-head-unit-msbc
    echo "...done"
else
    echo "Switching $card to a2dp..."
    pactl set-card-profile $card a2dp-sink
    echo "...done"
fi
