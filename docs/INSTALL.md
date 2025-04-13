# Installation Guide

This guide explains how to install the `just-so` system on a Linux machine once the filesystem has been properly configured. If you haven't set up Btrfs and subvolumes yet, please see [SETUP](./SETUP.md) first.

---

## 🚀 Quick Install (Recommended)

A helper script is included to automate the install process. Run it from the root of the project repository:

```bash
sudo ./INSTALL
```

This script will:
- Copy the `justso` script to `/usr/local/sbin/`
- Copy the systemd unit file to `/etc/systemd/system/`
- Set correct permissions

---

## 📁 Manual File Installation

If you prefer manual setup, follow these steps:

### 1. Copy the `justso` script

```bash
sudo install -m 755 usr/local/sbin/justso /usr/local/sbin/justso
```

This installs the main executable script to your system's `PATH`.

### 2. Copy the systemd unit file

```bash
sudo install -m 644 etc/systemd/system/justso@.service /etc/systemd/system/justso@.service
```

This installs the templated systemd service that allows rollback to be enabled per user.

---

## ⚙️ Enable Auto-Restore for a User

Once the files are in place, use the included convenience command to enable rollback for a user:

```bash
sudo justso enable <username>
```

To disable the rollback service for a user:

```bash
sudo justso disable <username>
```

These commands wrap the necessary `systemctl` calls to simplify usage for non-technical users.

---

## 🔄 Update systemd Daemon (if needed)

If you've just added or modified the service file and it doesn't seem recognized:

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
```

---

## 🧹 Uninstallation (optional)

Before removing Just-So, first disable the service for each user:

```bash
sudo justso disable <username>
```

Then remove the installed files:

```bash
sudo rm /usr/local/sbin/justso
sudo rm /etc/systemd/system/justso@.service
sudo systemctl daemon-reload
```

---

## ✅ Next Step

Once installed, follow the [USAGE](./USAGE.md) guide to initialize, snapshot, and manage rollback users.


