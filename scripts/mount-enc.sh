#!/bin/bash -x
# sudo powertop --auto-tune
sudo fsck /dev/sda1 -y
sudo fsck /dev/sda2 -y
sudo fsck /dev/sda3 -y
sudo fsck /dev/sda3 -y
sudo cryptdisks_stop home-enc | true
sudo cryptdisks_start home-enc
sudo fsck -a /dev/mapper/home-enc
sudo mkdir /media/tpasch/5e3b3f3a-029c-4d60-9968-acc2c6c1a234
sudo mount UUID=5e3b3f3a-029c-4d60-9968-acc2c6c1a234 /media/tpasch/5e3b3f3a-029c-4d60-9968-acc2c6c1a234
source /media/tpasch/5e3b3f3a-029c-4d60-9968-acc2c6c1a234/tpasch/.bashrc
ln -fs /media/tpasch/5e3b3f3a-029c-4d60-9968-acc2c6c1a234/tpasch/.bashrc ~/
sudo swapon UUID="74000971-7dac-48f4-9404-c5759cf478f7" 
exec bash
