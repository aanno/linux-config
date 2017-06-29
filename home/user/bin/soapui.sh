#!/bin/bash -x

SOAPUI="/home/tpasch/SoapUI-5.2.1"
cd "$SOAPUI/bin/"
exec "./soapui.sh" $*
