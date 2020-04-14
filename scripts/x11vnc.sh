#!/bin/bash -x

# x11vnc -v -6 -repoen -loop -forever -tightfilexfer -ultrafilexfer -avahi -vncconnect -allow 192.168.1. -usepw -find -findauth -xvnc -ncache
killall -9 x11vnc 
rm ~/x11vnc.log
x11vnc -rfbauth ~/.vnc/passwd -ncache 10 -usepw -forever -avahi -find -xvnc -allow 192.168.1. -tightfilexfer -ultrafilexfer -xinerama -xwarppointer -clip xinerama0 -ssl -bg -o ~/x11vnc.log
# -svc -bg -loopbg -o ~/x11vnc.log
# -bg -o ~/x11vnc.log
