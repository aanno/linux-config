#!/bin/sh

clevis-luks-unlock -d /dev/sdb4
clevis-luks-unlock -d /dev/sda2
sleep 1

clevis-luks-unlock -d /dev/mapper/luks-d06d9725-48db-4b3f-bc21-b7daa38a5264
clevis-luks-unlock -d /dev/mapper/luks-aa8fd8fc-ff77-4f86-9420-b8588c1eedce
sleep 1

clevis-luks-unlock -d /dev/mapper/vg_hdd-ssdtmp
clevis-luks-unlock -d /dev/mapper/vg_hdd-home

true
