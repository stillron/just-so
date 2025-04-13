# Architecture Overview

This document explains how `just-so` works behind the scenes. It covers how Btrfs subvolumes are managed, how systemd is used to trigger restoration, and how the script is structured for clarity and extensibility.

---

## 🗂 Subvolume and Snapshot Design

Each user’s home directory is stored as a **Btrfs subvolume**, e.g.:
```
/home/alice   →  subvolume: @alice
```

Snapshots are stored in:
```
/home/.snapshots/alice/YYYY-MM-DDTHH:MM:SS/
```

The snapshot system is lightweight and copy-on-write, ensuring fast performance and minimal disk space usage.

---

## 🔁 Rollback Flow

When a rollback is triggered (usually at boot via systemd):
1. The active home subvolume (`@alice`) is deleted.
2. The most recent snapshot from `.snapshots/alice/` is used to recreate the subvolume.
3. The restored subvolume is mounted at `/home/alice`.

This gives the appearance of a “reset” user environment.

---

## ⚙️ systemd Integration

The project uses a **templated systemd service**: `justso@.service`

When enabled for a user:
```bash
sudo systemctl enable justso@alice
```
…it runs on boot with:
```bash
ExecStart=/usr/local/sbin/justso back alice
```

This ensures user rollback occurs *before* the login screen appears.

---

## 🧠 Script Internals

The `justso` script is a **multi-command bash utility**. Internally, it uses functions for modularity:

- `make()`: create subvolumes and initial snapshot
- `enable()` / `disable()`: wrap systemctl for ease of use
- `pin()`: create a timestamped snapshot
- `back()`: delete current subvolume and recreate it from latest snapshot
- `unpin()`: remove newest snapshot
- `prune()`: remove oldest snapshot(s)
- `send()` / `receive()`: export and import snapshots for consistent replication across systems

Command dispatch is handled via:
```bash
case "$1" in
  init|make|enable|disable|pin|back|unpin|prune|send|receive)
    ...
```

Each command receives and validates arguments before performing its operation.

---

## 📦 Snapshot Export/Import

To facilitate consistent environments across many machines, `justso` includes snapshot transfer commands:

- `send <username>`: Compresses and exports the latest snapshot for a user to a `.gz` file.
- `receive <username> <file>`: Imports that `.gz` snapshot file and integrates it into the local system's snapshot folder.

This makes it easy to:
- Set up a clean desktop environment on a test VM
- Export the snapshot
- Distribute and apply it identically to all public-use computers

This pattern promotes total consistency between systems with minimal effort.

---

## 📒 Logging and Safety

- Logs are output to journal via `echo`, viewable with `journalctl -u justso@username`
- All destructive operations (like subvolume deletion) are gated by sanity checks
- Snapshots are only pruned or unpinned based on naming/time-order logic

---

## 🔐 Assumptions and Constraints

- The system uses Btrfs with subvolumes (not simple folders)
- Each user has a dedicated subvolume
- Snapshots are stored under a known path with strict formatting
- Rollbacks must be run as root, often via systemd
- `send` and `receive` functions assume common gzip and Btrfs tooling

---

## 🚧 Possible Future Enhancements

- Status command to show active snapshot state
- Backup/export of snapshots before rollback
- Logging to dedicated file for historical records
- Integration with login/logout hooks (outside systemd)
- Snapshot versioning and metadata tracking

---

## 🧭 See Also

- [USAGE](./USAGE.md): CLI command reference
- [INSTALL](./INSTALL.md): Script and service file setup
- [SETUP](./SETUP.md): System layout with Btrfs and fstab
- [README](../README.md): Project overview


