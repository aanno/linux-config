#!/bin/bash
# sudo powertop --auto-tune
#sudo cryptdisks_stop home-enc | true
#sudo cryptdisks_start home-enc
#sudo fschk /dev/mapper/home-enc
#sudo mkdir /media/tpasch/5e3b3f3a-029c-4d60-9968-acc2c6c1a234
sudo umount /media/tpasch/5e3b3f3a-029c-4d60-9968-acc2c6c1a234
#source /media/tpasch/5e3b3f3a-029c-4d60-9968-acc2c6c1a234/tpasch/.bashrc
# ln -fs /media/tpasch/5e3b3f3a-029c-4d60-9968-acc2c6c1a234/tpasch/.bashrc ~/
sudo swapoff UUID="74000971-7dac-48f4-9404-c5759cf478f7" 
sudo cryptdisks_stop home-enc | true
