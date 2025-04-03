#!/bin/bash -x

killall snapserver pw-record || true
sudo modprobe snd_aloop || true
mkfifo /tmp/snapfifo || true
snapserver &
pw-record -P stream.capture.sink=true --target alsa_output.platform-snd_aloop.0.analog-stereo - >/tmp/snapfifo &
