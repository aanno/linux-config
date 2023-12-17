#!/bin/bash -x

powertop --auto-tune

echo 'on' > '/sys/bus/usb/devices/1-11/power/control'
echo 'on' > '/sys/bus/usb/devices/1-8/power/control'

echo 'enabled' > '/sys/bus/usb/devices/usb3/power/wakeup'
echo 'enabled' > '/sys/bus/usb/devices/2-9.1/power/wakeup'
echo 'enabled' > '/sys/bus/usb/devices/1-7/power/wakeup'
echo 'enabled' > '/sys/bus/usb/devices/usb1/power/wakeup'
echo 'enabled' > '/sys/bus/usb/devices/usb4/power/wakeup'
echo 'enabled' > '/sys/bus/usb/devices/usb2/power/wakeup'
echo 'enabled' > '/sys/bus/usb/devices/2-9/power/wakeup'
echo 'enabled' > '/sys/bus/usb/devices/1-7.4/power/wakeup'

powertop

