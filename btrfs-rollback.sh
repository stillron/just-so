#!/bin/bash

/usr/bin/mount /dev/vda3 /root/topsubs

LATEST=$(stat -c '%y %n' /root/topsubs/@snapshots/* | sort -n -r | head -n 1 | cut -f 4 -d " ")
echo $LATEST

/usr/bin/umount /home/"$1"

echo "@$1"
/usr/bin/btrfs subvolume delete -c /root/topsubs/@$1


/usr/bin/btrfs subvolume snapshot $LATEST /root/topsubs/@$1

/usr/bin/umount /dev/vda3

/usr/bin/mount /home/"$1"



