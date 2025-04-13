# Just-So

**Just-So** is a lightweight, system-level utility that restores Linux user home directories to a clean state using **Btrfs snapshots**. Designed for environments with shared public computers—such as libraries, classrooms, or labs—Just-So ensures a consistent, privacy-respecting experience for each user session.

---

## ✨ Features

- Automatically restores user home directories on every reboot
- Creates and manages Btrfs snapshots for rollback
- Supports per-user rollback via templated systemd service (`justso@username.service`)
- Includes tools for snapshot pinning, pruning, and testing
- Set up a clean desktop environment once and deploy it to dozens or hundreds of machines using snapshot export/import
- Easy-to-use command-line interface

---

## 📦 Installation

To install Just-So, refer to the [INSTALL](docs/INSTALL.md) guide for manual setup and file placement.

For system configuration with Btrfs and subvolume layout, see [SETUP](docs/SETUP.md).

---

## 🚀 Usage

Once installed and configured, use Just-So to create and manage snapshots, enable auto-rollback for users, and maintain a clean computing environment.

See the [USAGE](docs/USAGE.md) guide for detailed commands and examples.

---

## 🧠 Why This Exists

In public computing environments, maintaining privacy and system consistency is essential. As an IT librarian, I needed a fast and low-maintenance solution to ensure that each user session starts from a known-good state without manual reimaging or full system lockdown.

A key feature of Just-So is the ability to set up a single reference desktop on one machine (or VM), export the snapshot, and then import that exact snapshot onto any number of public-use computers. This allows for consistent, reproducible desktop environments across an entire fleet with minimal effort.

This project is also part of a broader goal: making open source tools like Linux more approachable and practical for libraries. Many public libraries would benefit from using free and open technologies, but they need tools that are stable, repeatable, and easy to deploy. Just-So aims to be one of those tools.

---

## 📚 Documentation Index

- [INSTALL](docs/INSTALL.md): File installation steps
- [USAGE](docs/USAGE.md): CLI usage and examples
- [ARCHITECTURE](docs/ARCHITECTURE.md): How it works under the hood
- [VISION](docs/VISION.md): The philosophy behind Just-So and its role in promoting open source in libraries


---


## 🌍 Vision

Just-So is part of a larger effort to make open source software more usable and sustainable in public libraries. While it was created to solve a specific challenge — maintaining consistent and private public-access computers — it also fits into a broader philosophy:

Public libraries should be able to confidently adopt Linux and other free tools without requiring deep technical expertise. Projects like Just-So (and its sibling tool, Stations) are designed to help make that possible.

Read more about the mission in the [VISION](docs/VISION.md) document.

---

## 🪪 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


