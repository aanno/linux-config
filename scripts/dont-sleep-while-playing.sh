#! /bin/bash
# https://www.kubuntuforums.net/forum/general/desktop-support/plasma-support/70585-don-t-sleep-while-playing-audio
# cp -i /usr/lib/systemd/system/ydotool.service .config/systemd/user/
# systemctl start --user ydotool.service

# https://discussion.fedoraproject.org/t/implications-of-change-permissions-on-uinput/128865
# sudo groupadd -r uinput
# sudo usermod -a -G uinput my_username
# sudo udevadm control --reload-rules
# echo "SUBSYSTEM==\"misc\", KERNEL==\"uinput\", GROUP=\"uinput\", MODE=\"0660\"" | sudo tee /etc/udev/rules.d/uinput.rules
# echo uinput | sudo tee /etc/modules-load.d/uinput.conf

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
