#!/bin/bash -x

# Logitech receiver
echo 'on' > '/sys/bus/usb/devices/1-3.5.2/power/control';
# wired keyboard
echo 'on' > '/sys/bus/usb/devices/1-3.5.3/power/control';

