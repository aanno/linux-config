#!/bin/sh

NW_TEST=`ip a | grep 192.168.10.`
if [ -z $NW_TEST ]; then
	dhclient br0
fi

KRELEASE=`uname -r`

insmod "/lib/modules/$KRELEASE/kernel/drivers/platform/x86/mxm-wmi.ko.xz"
insmod "/lib/modules/$KRELEASE/kernel/drivers/gpu/drm/drm_ttm_helper.ko.xz"
insmod "/lib/modules/$KRELEASE/kernel/drivers/gpu/drm/nouveau/nouveau.ko.xz"

sleep 1

systemctl restart sddm


