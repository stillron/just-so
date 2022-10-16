#!/bin/bash

#Functions

rollback() {
    /usr/bin/mount /dev/vda3 /root/topsubs

    LATEST=$(stat -c '%y %n' /root/topsubs/@snapshots/$1/* | sort -n -r | head -n 1 | cut -f 4 -d " ")
    echo $LATEST

    /usr/bin/umount /home/"$1"

    echo "@$1"
    /usr/bin/btrfs subvolume delete -c /root/topsubs/@$1

    /usr/bin/btrfs subvolume snapshot $LATEST /root/topsubs/@$1

    /usr/bin/umount /dev/vda3

    /usr/bin/mount /home/"$1"
}

#Determine which function the user passed in to the command

case "$1" in
    "") ;;
    rollback) "$@"; exit;;
    *) echo "Unknown function: $1"; exit 2;;
esac
