#!/bin/bash -x

export DISPLAY=":99" 
( xinit /usr/bin/startxfce4 -- /usr/bin/Xvfb $DISPLAY -screen 0 1600x1200x24 ) &
sleep 8
( x11spice --generate-password --allow-control --display $DISPLAY ) &
sleep 8
( spice-vdagentd -d -f -x -X -S /tmp/vdagent -s /tmp/xspice-virtio -u /tmp/xspice-uinput ) &
sleep 8
( spice-vdagent -o 1 -d -x -S /tmp/vdagent -s /tmp/xspice-virtio ) &
echo "spice up and running"

