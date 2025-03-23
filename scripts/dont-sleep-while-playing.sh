#! /bin/bash
# https://www.kubuntuforums.net/forum/general/desktop-support/plasma-support/70585-don-t-sleep-while-playing-audio
# cp -i /usr/lib/systemd/system/ydotool.service .config/systemd/user/
# systemctl start --user ydotool.service

State=1
# while [ State != 0 ]; do
while true; do

if cat /proc/asound/card*/pcm*/sub*/status | grep -c 'state: RUNNING'; then
  let State=1
  # echo "Playing $State"
  ydotool mousemove -x -1 -y -1
  sleep 1s
  ydotool mousemove -x 1 -y 1
else
  let State=0
  # echo "Idle $State"
fi
#sleep 4m
sleep 1s

done
