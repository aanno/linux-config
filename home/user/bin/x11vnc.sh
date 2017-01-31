#!/bin/bash
nohup x11vnc -no6 -findauth -usepw -forever -bg -shared -avahi -allow 192.168. >$HOME/x11vnc.log 2>&1

