# Usage Guide

This guide explains how to use the `justso` command-line tool to manage rollback functionality for user home directories.

The script supports common administrative tasks through subcommands that simplify snapshot creation, service control, and user management.

---

## 📋 Basic Command Structure

```bash
sudo justso <command> [username] [options]
```

Most commands require root privileges. Replace `[username]` with the appropriate system user's name.

---

## ⚙️ Initialization

```bash
sudo justso init
```

Initializes system-wide configuration needed for using `justso`. Run this once after system setup.

---

## 👤 Create and Set Up User for Rollback

```bash
sudo justso make <username>
```

Creates a Btrfs subvolume for the user's home directory and prepares it for use with `justso`.

---

## 🔁 Enable and Disable Rollback

Enable rollback (auto-restore) on reboot:
```bash
sudo justso enable <username>
```

Disable rollback:
```bash
sudo justso disable <username>
```

These wrap `systemctl enable/disable justso@username`.

---

## 📌 Snapshot Pinning

To save the current state of a user’s home directory:
```bash
sudo justso pin <username>
```

This creates a timestamped snapshot in that user's snapshot folder.

---

## ↩️ Manual Roll Back to Latest Snapshot

```bash
sudo justso back <username>
```

Reverts the user's home directory to the most recent pinned snapshot.

---

## 🧽 Snapshot Maintenance

Remove the most recent snapshot:
```bash
sudo justso unpin <username>
```

Remove the oldest snapshot(s):
```bash
sudo justso prune <username> [count]
```

Examples:
```bash
sudo justso prune alice         # Remove oldest snapshot
sudo justso prune alice 3       # Remove 3 oldest snapshots
```

---

## 🚚 Export and Import Snapshots

Export the latest snapshot to a compressed archive:
```bash
sudo justso send <username>
```

This will generate a `.gz` file containing the user's most recent snapshot, which can be transferred to other systems.

Import a previously exported snapshot:
```bash
sudo justso receive <username> <snapshot-file.gz>
```

This restores the snapshot into the appropriate `.snapshots/username/` directory for use in rollback.

---

## 🔎 Check Current Status (Planned)

_Not yet implemented:_
```bash
sudo justso status <username>
```

Would show active snapshot, subvolume details, and rollback status.

---

## 📚 Related Documentation

- [INSTALL](./INSTALL.md): File installation steps
- [SETUP](./SETUP.md): System layout and Btrfs config
- [ARCHITECTURE](./ARCHITECTURE.md): How it works internally


