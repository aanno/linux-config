#!/bin/bash -x

killall snapserver pw-record || true
if lsmod | grep -q snd_aloop; then
  echo "snd_aloop already loaded"
else
  sudo modprobe snd_aloop || true
fi
rm -f /tmp/snapfifo
mkfifo /tmp/snapfifo || true
snapserver &
pw-record -P stream.capture.sink=true --target alsa_output.platform-snd_aloop.0.analog-stereo - >/tmp/snapfifo &
xdg-open http://localhost:1780/ || true
