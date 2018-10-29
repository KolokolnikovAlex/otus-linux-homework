#!/bin/bash

echo "RAID 5 Creation"
echo 

mdadm --create --verbose /dev/md0 -l 5 -n 4 /dev/sd{b,c,d,e}

echo "DEVICE partitions" > /etc/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/{print}' >> /etc/mdadm.conf

parted -s /dev/md0 mklabel gpt
parted /dev/md0 mkpart primary ext4 0% 20%
parted /dev/md0 mkpart primary ext4 20% 40%
parted /dev/md0 mkpart primary ext4 40% 60%
parted /dev/md0 mkpart primary ext4 60% 80%
parted /dev/md0 mkpart primary ext4 80% 100%

for i in $(seq 1 4); do mkfs.ext4 /dev/md0p$i; done 

mkdir -p /raid/part{1,2,3,4}

for i in $(seq 1 4); do mount /dev/md0p$i /raid/part$i; done 
