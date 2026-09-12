# Waybar Configuration

A [Waybar](https://github.com/Alexays/Waybar) status bar setup for Hyprland, with workspace/window/language modules, a notification indicator (SwayNotificationCenter), a scrolling "now playing" media widget, a hoverable backlight/volume slider drawer, and live config reloading.

> ⚠️ **Personal setup:** this config assumes Hyprland, a specific font, and a handful of personal helper tools/scripts (some paths and click actions are hardcoded to my machine). Read through [What to Customize](#-what-to-customize) before using it as-is.

---

## 📁 Files

```text
config.jsonc              # Waybar module layout & behavior
style.css                 # Waybar theme (colors, spacing, sliders)
auto-reload.sh             # Watches the config folder and reloads Waybar on save
custom_modules/media/
├── media-now-playing.sh   # Scrolling "title - artist" via zscroll
├── media-animation.sh     # Animated equalizer-style bars while playing
└── media-time.sh          # Current track position / duration
```

> **Note:** `config.jsonc` references the media scripts at `~/.config/waybar/custom_modules/media/*.sh` — see [Installation](#-installation) for where to place them.

---

## ✨ Features

- 🖥️ Hyprland workspace indicator, active window title, active keybind submap, and keyboard layout display
- 🔔 Notification icon that reflects SwayNotificationCenter state (unread / DND / inhibited)
- 🎵 Scrolling now-playing widget with an animated "equalizer" indicator and live track position, all driven by `playerctl`
- 🔊 Volume module with a hover-out slider drawer
- 💡 Backlight module with a hover-out brightness slider drawer
- 🔋 Battery, 🌐 network, 🧠 CPU, and 🗂️ memory modules, each clickable to open a relevant tool
- 🔄 Auto-reloads Waybar whenever a config file changes, via `inotifywait`

---

## ✅ Prerequisites

### Core

| Tool | Why it's needed | Install (Arch) |
|---|---|---|
| **Waybar** | The status bar itself | `sudo pacman -S waybar` |
| **Hyprland** | Powers the `hyprland/workspaces`, `hyprland/window`, `hyprland/submap`, and `hyprland/language` modules | See the separate Hyprland README |
| **JetBrainsMono Nerd Font Propo** | Font used throughout `style.css` | [nerdfonts.com](https://www.nerdfonts.com/font-downloads) — download "JetBrainsMono Nerd Font", the Propo (proportional) variant is included in the same archive |
| **Cairo font** | Fallback font, used for Arabic text (keyboard layout label) | Arch: `sudo pacman -S ttf-cairo` (or any package providing the Cairo typeface) |
| **otf-font-awesome** | Icon glyphs used across most modules | `sudo pacman -S otf-font-awesome` |
| **inotify-tools** | Provides `inotifywait`, used by `auto-reload.sh` | `sudo pacman -S inotify-tools` |

### Notifications & media

| Tool | Why it's needed | Install (Arch) |
|---|---|---|
| **swaync** (SwayNotificationCenter) | Powers the `custom/notification` module's icon state and click actions | `sudo pacman -S swaync` |
| **playerctl** | Media metadata/control for all three media scripts | `sudo pacman -S playerctl` |
| **zscroll** | Scrolls the "now playing" text | AUR: `yay -S zscroll` |

### System modules

| Tool | Why it's needed | Install (Arch) |
|---|---|---|
| **bluetui** | Bluetooth TUI opened by clicking the bluetooth module | AUR: `yay -S bluetui` |
| **btop** | Opened by clicking the CPU module | `sudo pacman -S btop` |
| **htop** | Opened by clicking the memory module | `sudo pacman -S htop` |
| **pavucontrol** | Opened by clicking the volume module | `sudo pacman -S pavucontrol` |
| **Ghostty** | Terminal used to launch `bluetui`/`btop`/`htop` in a floating window | See the separate Ghostty/Zsh README |
| **Firefox** | Opened by clicking the clock (Google Calendar) | `sudo pacman -S firefox` |
| **nmrs** or another network menu | Opened by clicking the network module (`exec nmrs`) | Replace with your own network manager TUI/menu if `nmrs` isn't something you have — e.g. `nmtui`, or a rofi-based network menu |
| **intel_backlight** device | Assumed by the `backlight` and `backlight/slider` modules | If your GPU isn't Intel, change `device` in `config.jsonc` to your own (e.g. `amdgpu_bl0` — check `ls /sys/class/backlight/`) |
| **UPower** | Backs the `battery` module (usually already present via Waybar's dependencies) | `sudo pacman -S upower` |

---

## 🚀 Installation

1. **Install all prerequisites** from the tables above.

2. **Copy the config files:**
   ```bash
   mkdir -p ~/.config/waybar/custom_modules/media
   cp config.jsonc style.css auto-reload.sh ~/.config/waybar/
   cp media-now-playing.sh media-animation.sh media-time.sh ~/.config/waybar/custom_modules/media/
   ```

3. **Make the scripts executable:**
   ```bash
   chmod +x ~/.config/waybar/auto-reload.sh
   chmod +x ~/.config/waybar/custom_modules/media/*.sh
   ```

4. **Adjust machine-specific settings** — see [What to Customize](#-what-to-customize) below (backlight device name, the `nmrs` network command, and anything else that doesn't match your setup).

5. **Launch Waybar** (this is already handled automatically if you're using the Hyprland config from this repo, which autostarts Waybar):
   ```bash
   waybar &
   ```

6. **(Optional) Enable live-reload on config changes:**
   ```bash
   ~/.config/waybar/auto-reload.sh &
   ```
   Add this to your Hyprland autostart if you want it to run automatically every session.

---

## 🛠️ What to Customize

| Setting | Location | What to change it to |
|---|---|---|
| Backlight device | `"backlight"` and `"backlight/slider"` in `config.jsonc` | Run `ls /sys/class/backlight/` and use whatever shows up (`intel_backlight`, `amdgpu_bl0`, etc.) |
| Network click action | `"network": { "on-click": "exec nmrs" }` | Replace `nmrs` with your own network manager command/TUI |
| Bluetooth/CPU/memory click actions | `"on-click"` fields for `bluetooth`, `cpu`, `memory` | These assume Ghostty as your terminal — swap `ghostty` for your own terminal emulator's equivalent flags, or a different tool entirely |
| Calendar click action | `"clock": { "on-click": "firefox ..." } ` | Replace with your preferred browser/calendar |
| Font | `style.css` → `font-family` | Swap for whatever Nerd Font you have installed if not using JetBrainsMono |
| Colors | `style.css` → `@define-color` block at the top | Change `highlight` and the `dark-*` shades to your preferred palette |

---

## 🎨 Module Overview

| Position | Module | What it shows |
|---|---|---|
| Left | `hyprland/workspaces` | Active workspace indicators |
| Left | `hyprland/language` | Current keyboard layout (EN / عربي), click to switch |
| Left | `group/media` | Animated equalizer + scrolling track title/artist + position |
| Center | `clock` | Date/time, click opens Google Calendar |
| Center | `custom/notification` | Notification bell reflecting swaync state |
| Right | `hyprland/window` | Active window title (truncated to 50 chars) |
| Right | `hyprland/submap` | Active Hyprland keybind submap, if any |
| Right | `group/backlight-drawer` | Brightness % with a hover-out slider |
| Right | `group/volume` | Volume % with a hover-out slider |
| Right | `battery` | Battery percentage with charging-aware icons |
| Right | `bluetooth` | Connection status, click opens `bluetui` |
| Right | `network` | Wifi/ethernet status, click opens network menu |
| Right | `cpu` | CPU usage %, click opens `btop` |
| Right | `memory` | RAM usage %, click opens `htop` |

---

## 🩺 Troubleshooting

| Problem | Fix |
|---|---|
| Icons show as boxes/`?` | Install `otf-font-awesome` and the JetBrainsMono Nerd Font |
| Arabic layout label doesn't render | Install a font providing Arabic glyphs (Cairo, or any Arabic-supporting Nerd Font fallback) |
| Media modules show nothing | `playerctl` isn't installed, or no media player is currently running |
| Now-playing text doesn't scroll | `zscroll` isn't installed |
| Config changes don't apply automatically | `inotify-tools` isn't installed, or `auto-reload.sh` isn't running |
| Backlight slider doesn't adjust brightness | Wrong `device` name in `config.jsonc`, or missing write permission on `/sys/class/backlight/<device>/brightness` (add a udev rule or run via a permitted group) |
| Bluetooth/CPU/memory clicks do nothing | The referenced tool (`bluetui`, `btop`, `htop`) or Ghostty isn't installed |
| Network click does nothing | `nmrs` isn't a real command on your system — replace it (see [What to Customize](#-what-to-customize)) |
| Notification icon always shows the same state | `swaync` isn't installed or `swaync-client` isn't on `PATH` |

---

## 🙌 Contributing / Feedback

This is a personal setup shared for others to learn from or adapt. Feel free to open an issue or PR if you spot something broken or have a suggestion.
