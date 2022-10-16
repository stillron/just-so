#!/bin/bash

#Variables

# if [[ -n $(which btrfs) ]]; then
    # BTRFS=$(which btrfs)
# fi

#Functions

rollback() {
    mount /dev/vda3 /root/topsubs
    LATEST=$(stat -c '%y %n' /root/topsubs/@snapshots/"$1"/* | sort -n -r | head -n 1 | cut -f 4 -d " ")
    # echo "$LATEST"
    umount /home/"$1"
    echo "@$1"
    btrfs subvolume delete -c /root/topsubs/@"$1"
    btrfs subvolume snapshot "$LATEST" /root/topsubs/@"$1"
    umount /dev/vda3
    mount /home/"$1"
}

#Determine which function the user passed in to the command

case "$1" in
"") ;;
rollback)
    "$@"
    exit
    ;;
*)
    echo "Unknown function: $1"
    exit 2
    ;;
esac
