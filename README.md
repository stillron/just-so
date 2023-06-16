# JustSo

BTRFS-based snapshots provide automatic rollbacks of user home folders.

## Setup

### Debian

1. Start the setup process by Selecting `Advanced Options > Expert Install`
1. Go through:
    1. Language
    1. Keyboard
    1. Detect installation media
    1. Load Installer components
    1. Detect Network Hardware
    1. Configure the Network
    1. Setup users and passwords (lebtech)
    1. Configure the clock
    1. Detect disks
1. At partition disks create new GPT partition

#### Create EFI Partition

1. Go down to `FREE SPACE` and press enter to create the first (EFI) partition.
1. Choose `Create a new partition`
1. Enter 1 GB for size and select `Beginning` for position of partition.
1. On the next screen, choose `Use as` and select `EFI System Partition`
1. Choose `Done` from menu

#### Create Swap Partition

1. Go down to `FREE SPACE` again to setup swap partition.
1. Choose `Create a new partition`
1. Make size 1.5 x Amount of RAM on the machine and select `Beginning` for position of partition.
1. On the next screen, choose `Use as` and select `Swap area`
1. Choose `Done` from menu

#### Create BTRFS partition

1. Go down to `FREE SPACE` again to setup BTRFS partition.
1. Choose `Create a new partition`
1. Leave size at remaining space available.
1. On the next scree, choose `Use as` and select `btrfs journaling filesystem`
1. Choose `Done`

#### Writing out the partitions to disk

1. Arrow down to `Finish partitioning and write changes to disk` and press enter.
1. Answer `Yes` to all prompts

### Setting up initial subvolumes

1. **DO NOT CONTINUE TO NEXT STEP in installer** (yet).
1. Instead press CTRL+ALT+F2 to get a terminal window.
1. Enter `df` command to see which partitions are mounted at:
    * /target
    * /target/boot/efi

1. umount the two above partitions.
1. mount whatever partition was previously mounted to `/target` to `/mnt`
1. cd to `/mnt`
1. rename root snapshot from `@rootfs` to `@`
1. create @home subvolume with:

```bash
btrfs subvolume create @home
```

9. mount the root subvolume to target with:

```bash
mount -o rw,noatime,compress=zstd,space_cache,subvol=@ /dev/sd<X> /target
```

10. create directories to mount to inside of **/target**
    1. First `mkdir -p /target/boot/efi`
    1. then `mkdir /target/home`
1. Mount **/home** with:

```bash
mount -o rw,noatime,compress=zstd,space_cache,subvol=@home /dev/sd<X> /target/home
```

12. Mount **/boot/efi** with

```bash
mount /dev/<PARTITION PREVIOUSLY MOUNTED TO _boot/efi_> /target/boot/efi
```

### Updating /etc/fstab

Now we need to reflect our recent changes in fstab.  Use `nano` to edit **/target/etc/fstab**

The lines for **/** and **/home** should look like the following:

```bash
UUID=<(NO CHANGE NEEDED)> /  btrfs   rw,noatime,compress=zstd,space_cache,subvol=@   0 0
UUID=<SAME AS ABOVE>      /  btrfs   rw,noatime,compress=zstd,space_cache,subvol=@home   0 0
```
### Return to installer

All manual updates are now done.  Return to installer by typing `exit` in the command line and then entering `CTRL+ALT+F1`

## Usage
