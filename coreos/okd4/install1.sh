virt-install --connect qemu:///system -n fcos -r 8196 --os-variant=fedora31 --qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=/mnt/nocrypt-ext4/home/tpasch/my.ign" --import --graphics=none --disk size=10,backing_store=/mnt/home/tpasch/Downloads/okd4/f31core.qcow2 --network network=default