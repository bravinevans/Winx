<div align="center">
  <img src="profile/airootfs/usr/share/pixmaps/winx-logo.svg" alt="WinX OS Logo" width="140" height="140" />
  <h1>WinX OS</h1>
  <p><strong>Intuitive desktop. Console-grade gaming. Zero bloat.</strong></p>
  <p>
    An Arch-based Linux distribution built for people who want their computer to work out of the box—combining a clean, familiar desktop layout, a graphical software store with full AUR access, a dedicated Steam Deck Console Mode, and an offline office suite with zero forced accounts or background clutter.
  </p>
</div>

---

## Core Experience

- **Zero Forced Accounts:** Boot straight into a local user profile with full offline control—no cloud sign-ins, telemetry, or bundled adware.
- **Familiar Desktop Workflow:** Powered by a lean **KDE Plasma 6** setup (`Breeze Dark` theme, `44px` bottom taskbar, pinned quick-launchers, and standard double-click navigation) so muscle memory transfers effortlessly.
- **WinX Store (GUI Software Center):** Search both official repositories and the **AUR** in one place, install apps with real-time progress logs, and keep the entire system up to date with a single click—no terminal required.
- **Desktop + Console Gaming:**
  - Pre-installed **Steam** (64-bit runtime), **Lutris**, **Wine-Staging**, **Winetricks**, **MangoHud**, and **GameMode**.
  - Switch directly into **WinX Console Mode (Steam Deck UI)** from the login screen via `gamescope` with HDR and Adaptive Sync (VRR) enabled.
  - Universal out-of-the-box Vulkan and 32-bit driver support for **AMD (`vulkan-radeon`)**, **Intel (`vulkan-intel`)**, and **NVIDIA (`nvidia-dkms`)**.
- **Offline Productivity Suite:** Pre-configured **WinX Word**, **WinX Excel**, and **WinX PowerPoint** featuring a tabbed Ribbon interface and full `.docx`, `.xlsx`, and `.pptx` compatibility.
- **Clean Architecture:** Built on the `linux-zen` kernel and `PipeWire` audio stack, with an offline **Calamares** graphical wizard for fast SSD/NVMe installation.

---

## Download & Install

WinX OS is distributed as a single, unsplit **~2.7 GB** bootable `.iso` hosted on a global CDN for fast, resumable downloads.

1. Grab the latest direct `.iso` download link and `.sha256` checksum from the [**Releases**](https://github.com/bravinevans/Winx/releases) page.
2. *(Optional)* Download via terminal with automatic connection resume and verify integrity:
   ```bash
   # Resume download using the direct URL from the latest Release
   aria2c -c -x 4 -s 4 <DIRECT_ISO_URL>

   # Verify file integrity
   sha256sum -c winx-os-*.iso.sha256

```

3. **Create Bootable Media:** Copy the `.iso` directly onto a **Ventoy** USB drive, or flash it using **Rufus**, **BalenaEtcher**, or `dd`:
```bash
sudo dd if=winx-os-*.iso of=/dev/sdX bs=4M status=progress oflag=sync

```


4. **Boot & Install:** Reboot from your USB drive into the live desktop, test everything out, and launch **Install WinX** from the desktop when ready to install to your drive.
