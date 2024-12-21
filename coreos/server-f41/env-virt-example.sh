# copy this as `.env-virt.sh` and adapt to your needs

# ~/.local/share/libvirt/images/fedora-coreos-41.20241122.3.0-qemu.x86_64.qcow2
IGNITION_CONFIG="minimal"
IMAGE=`ls ~/.local/share/libvirt/images/fedora-coreos-41.*-qemu.x86_64.qcow2`
VM_NAME="fcos-test-01"
VCPUS="2"
RAM_MB="2048"
STREAM="stable"
DISK_GB="10"

# must be absolute paths, hence
IMAGE=`readlink -f $IMAGE`
