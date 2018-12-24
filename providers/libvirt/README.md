# create base box for libvirt provider

## dependencies
## NOTE: This package is required to make a virt-sysprep on image
sudo apt install libguestfs-tools

## Before build libvirt images
sudo rm -rf /var/lib/libvirt/images/*
virsh pool-refresh default