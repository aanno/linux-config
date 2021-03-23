# absolute path needed
export IMAGE="$HOME/.local/share/libvirt/images/fedora-coreos-33.20210301.3.1-qemu.x86_64.qcow2"
export STREAM="stable"
export VCPUS="4"
export RAM_MB="8192"
export DISK_GB="10"
export NETWORK="network=br0"
# networking tp:
# 
# --network network=br0
# better, but always unstable, sometimes works, sometimes don't
# 
# --network network=default
# (Default) libvirt NAT networking: Networking will work, but services will only
# be available on dom0. CoreOS will report (local) ip address, like in
# 
# enp1s0: 192.168.122.91 fe80::5054:ff:fe8a:5fc2
# 

