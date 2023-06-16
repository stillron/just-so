# JustSo

BTRFS-based snapshots provide automatic rollbacks of user home folders.

## Setup

### Debian

1. Start the setup process by Selecting `Advanced Options > Expert Install`
* Go through:
  * Language
  * Keyboard
  * Detect installation media
  * Load Installer components
  * Detect Network Hardware
  * Configure the Network
  * Setup users and passwords (lebtech)
  * Configure the clock
  * Detect disks

* Then, at `Partition disks` create new GPT partition

#### Create EFI Partition

* Go down to `FREE SPACE` and press enter to create the first (EFI) partition.
* Choose `Create a new partition`
* Enter 1 GB for size and select `Beginning` for position of partition.
* On the next screen, choose `Use as` and select `EFI System Partition`
* Choose `Done` from menu

#### Create Swap Partition

* Go down to `FREE SPACE` again to setup swap partition.
* Choose `Create a new partition`
* Make size 1.5 x Amount of RAM on the machine and select `Beginning` for position of partition.
* On the next screen, choose `Use as` and select `Swap area`
* Choose `Done` from menu

#### Create BTRFS partition

* Go down to `FREE SPACE` again to setup BTRFS partition.
* Choose `Create a new partition`
* Leave size at remaining space available.
* On the next screen, choose `Use as` and select `btrfs journaling filesystem`
* Choose `Done`

#### Writing out the partitions to disk

* Arrow down to `Finish partitioning and write changes to disk` and press enter.
* Answer `Yes` to all prompts

### Setting up initial subvolumes

**DO NOT CONTINUE TO NEXT STEP in installer** (yet).

* Instead press CTRL+ALT+F2 to get a terminal window.

* Enter `df` command to see which partitions are mounted at:

```bash
/target
/target/boot/efi
```

* umount the two above partitions.
* mount whatever partition was previously mounted to `/target` to `/mnt`
* cd to `/mnt`
* rename root snapshot from `@rootfs` to `@`
* create @home subvolume with:

```bash
btrfs subvolume create @home
```

* mount the root subvolume to target with:

```bash
mount -o rw,noatime,compress=zstd,space_cache=v2,subvol=@ /dev/sd<X> /target
```

* create directories to mount to inside of **/target**
  * First `mkdir -p /target/boot/efi`
    *then `mkdir /target/home`

* Mount **/home** with:

```bash
mount -o rw,noatime,compress=zstd,space_cache=v2,subvol=@home /dev/sd<X> /target/home
```

* Mount **/boot/efi** with

```bash
mount /dev/<PARTITION PREVIOUSLY MOUNTED TO _boot/efi_> /target/boot/efi
```

### Updating /etc/fstab

Now we need to reflect our recent changes in fstab.  Use `nano` to edit **/target/etc/fstab**

The lines for **/** and **/home** should look like the following:

```bash
UUID=<(NO CHANGE NEEDED)> /  btrfs   rw,noatime,compress=zstd,space_cache=v2,subvol=@   0 0
UUID=<SAME AS ABOVE>      /  btrfs   rw,noatime,compress=zstd,space_cache=v2,subvol=@home   0 0
```

### Return to installer

All manual updates are now done.  Return to installer by typing `exit` in the command line and then entering `CTRL+ALT+F1`

Continue through the rest of the installation process.

## Usage
