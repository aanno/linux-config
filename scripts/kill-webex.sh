#!/bin/bash -x
export VERSION=$(basename `ls -d .local/share/WebexLauncher/4*`)

killall /mnt/home/tpasch/.local/share/WebexLauncher/${VERSION}/bin/CiscoCollabHostCef 
killall /home/tpasch/.local/share/WebexLauncher/${VERSION}/bin/CiscoCollabHost

