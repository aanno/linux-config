#!/bin/bash 

MOUSE_ID="lenovo usb laser"
MOUSE_VELOCITY="0.001"
MOUSE_ACCEL="-0.5"
# from 'xinput list-props $XINPUT_ID'
MOUSEV_PROPERTY="134"
MOUSEA_PROPERTY="273"

LINE_REGEX="id=([0-9]+)"
LINE=$(xinput list | grep -i "$MOUSE_ID")

if [[ $LINE =~ $LINE_REGEX ]]; then 
	# echo "${BASH_REMATCH[1]}"
	XINPUT_ID="${BASH_REMATCH[1]}"
	if [ -n "$XINPUT_ID" ]; then
		xinput set-prop "$XINPUT_ID" "$MOUSEV_PROPERTY" "$MOUSE_VELOCITY", 0, 0, 0, "$MOUSE_VELOCITY", 0, 0, 0, "$MOUSE_VELOCITY"
		echo "velocity of xinput '$MOUSE_ID' set to $MOUSE_VELOCITY (property=$MOUSEV_PROPERTY)"
		xinput set-prop "$XINPUT_ID" "$MOUSEA_PROPERTY" "$MOUSE_ACCEL"
		echo "accel of xinput '$MOUSE_ID' set to $MOUSE_ACCEL (property=$MOUSEA_PROPERTY)"
	else
		echo "could not determine id of xinput '$MOUSE_ID'"
		exit -1
	fi
else
	echo "failed to find xinput '$MOUSE_ID'"
	exit -1
fi
