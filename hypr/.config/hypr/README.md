# Hyprland Configuration

Personal [Hyprland](https://hyprland.org/) config using the newer **Lua configuration format** (`hyprland.lua`) rather than the classic `hyprland.conf` syntax, plus a [hyprpaper](https://github.com/hyprwm/hyprpaper) wallpaper setup.

> ⚠️ **Very personal setup:** this config hardcodes my machine's monitor names, home directory paths, personal apps (JetBrains Toolbox scripts, Spotify, a specific mouse/keyboard device), and keyboard layouts. Don't copy-paste it as-is — read through it and adjust the values marked below before using it.

---

## 📁 Files

```text
hyprland.lua      # Main Hyprland config — monitors, keybinds, look & feel, input, rules
hyprpaper.conf     # hyprpaper wallpaper config
```

> **Note:** Hyprland's Lua config support is a newer feature. Make sure your installed Hyprland version supports `hyprland.lua` — check the [Hyprland Lua config wiki page](https://wiki.hypr.land/Configuring/Start/) if `hl.*` calls aren't recognized.

---

## ✅ Prerequisites

Install these **before** applying the config.

### Core

| Tool | Why it's needed | Install (Arch) |
|---|---|---|
| **Hyprland** | The window manager/compositor itself | `sudo pacman -S hyprland` |
| **hyprpaper** | Sets the desktop wallpaper per monitor | `sudo pacman -S hyprpaper` |
| **waybar** | Status bar, launched on startup | `sudo pacman -S waybar` (see the separate Waybar README) |
| **rofi** | App launcher, run dialog, calculator, emoji picker, clipboard menu | `sudo pacman -S rofi` |
| **hyprpolkitagent** | Polkit authentication agent, started on login | `sudo pacman -S hyprpolkitagent` |

### Notifications, clipboard & media

| Tool | Why it's needed | Install (Arch) |
|---|---|---|
| **swaync** (SwayNotificationCenter) | Notification daemon + notification center, bound to `SUPER+N` | `sudo pacman -S swaync` |
| **cliphist** | Clipboard history, piped into rofi (`SUPER+SHIFT+C`) | `sudo pacman -S cliphist` |
| **wl-clipboard** | Provides `wl-copy`, used by the clipboard history bind | `sudo pacman -S wl-clipboard` |
| **playerctl** | Media key bindings (play/pause/next/prev) and `playerctld` daemon | `sudo pacman -S playerctl` |
| **hyprshot** | Screenshot tool bound to `SUPER+S` / `SUPER+SHIFT+S` / `SUPER+SHIFT+SPACE` | `sudo pacman -S hyprshot` (AUR) |

### Input & hardware control

| Tool | Why it's needed | Install (Arch) |
|---|---|---|
| **wireplumber** (provides `wpctl`) | Volume control on multimedia keys | `sudo pacman -S wireplumber` |
| **brightnessctl** | Screen brightness control, bound to media keys and `Ctrl+↑`/`Ctrl+↓` | `sudo pacman -S brightnessctl` |
| **Bibata-Modern-Ice** cursor theme | Cursor theme set at startup via `hyprctl setcursor` | AUR: `yay -S bibata-cursor-theme` |
| **qt6ct** | Qt6 theming, set via `QT_QPA_PLATFORMTHEME` | `sudo pacman -S qt6ct` |

### Personal apps referenced in this config

These are hardcoded in `hyprland.lua` and only make sense if you actually use them — swap them out for your own equivalents otherwise.

| App | Used for | Bind |
|---|---|---|
| Ghostty | Terminal | `SUPER+T` |
| Nemo | File manager | `SUPER+F` |
| Firefox | Browser | `SUPER+B` |
| Spotify | Music | `SUPER+M` |
| JetBrains Toolbox (IntelliJ IDEA / CLion) | IDEs, launched via Toolbox shell scripts | `SUPER+J` / `SUPER+C` |

> 💡 If you don't use JetBrains Toolbox, either remove the `intellij`/`clion` binds or point them at your own install paths (`/home/haithem/.local/share/JetBrains/Toolbox/scripts/...` is specific to my machine).

---

## 🚀 Installation

1. **Install all prerequisites** from the tables above.

2. **Copy the configs:**
   ```bash
   mkdir -p ~/.config/hypr
   cp hyprland.lua ~/.config/hypr/
   cp hyprpaper.conf ~/.config/hypr/
   ```

3. **Update machine-specific values** before launching — see [What to Customize](#-what-to-customize) below. At minimum, fix your monitor names/resolutions and the wallpaper path.

4. **Add your wallpaper(s)** to `~/.config/hypr/backgrounds/` (or update the `path` in `hyprpaper.conf` to wherever your wallpapers live).

5. **Start (or restart) Hyprland.** On login, this config automatically starts:
   - `waybar` (status bar)
   - `hyprpaper` (wallpaper)
   - `hyprpolkitagent` (auth agent)
   - `swaync` (notifications)
   - `playerctld` (media player tracking daemon)
   - Sets the cursor theme to Bibata-Modern-Ice at size 24

6. **Reload after editing** without a full restart:
   ```bash
   hyprctl reload
   ```

> ⚠️ **wpaperd vs hyprpaper conflict:** the autostart block execs both `wpaperd -d` **and** `hyprpaper` — these are two different wallpaper daemons and shouldn't run at the same time. Since `hyprpaper.conf` is provided, remove the `wpaperd -d` line from the autostart block in `hyprland.lua` unless you actually intend to use both.

---

## 🛠️ What to Customize

Before using this config, go through and update:

| Setting | Location | What to change it to |
|---|---|---|
| Monitor names/modes | `hl.monitor({...})` blocks | Run `hyprctl monitors` to get your actual monitor names and supported resolutions/refresh rates |
| Wallpaper path & monitor names | `hyprpaper.conf` | Your own wallpaper file path and matching monitor names |
| Keyboard layout | `input.kb_layout = "us,ara"` | Your own layout(s) — this one includes a US/Arabic toggle (`ALT+Shift_L` to switch) |
| JetBrains paths | `intellij`, `clion` locals | Your own Toolbox script paths, or remove if unused |
| Device-specific tweaks | `hl.device({ name = "epic-mouse-v1", ... })` and the `rdmctmzt-wireless-2.4g-dongle-keyboard` block | Run `hyprctl devices` to find your own device names, or delete these blocks |
| Home directory paths | `hyprpaper.conf` wallpaper `path` | Replace `/home/haithem/...` with your own username's path |

---

## ⌨️ Keybindings

**Main modifier:** `SUPER` · **Second modifier:** `SUPER + SHIFT`

### Apps & launchers

| Key | Action |
|---|---|
| `SUPER+T` | Open terminal (Ghostty) |
| `SUPER+F` | Open file manager (Nemo) |
| `SUPER+B` | Open browser (Firefox) |
| `SUPER+M` | Open music (Spotify) |
| `SUPER+J` | Open IntelliJ IDEA |
| `SUPER+C` | Open CLion |
| `SUPER+D` | App launcher (rofi drun) |
| `SUPER+Space` | Run dialog (rofi) |
| `SUPER+E` | Emoji picker (rofi) |
| `SUPER+SHIFT+C` | Clipboard history (cliphist + rofi) |

### Notifications & system

| Key | Action |
|---|---|
| `SUPER+N` | Toggle notification center (swaync) |
| `SUPER+SHIFT+N` | Dismiss notifications |
| `ALT+Shift_L` | Switch keyboard layout (US ↔ Arabic) |
| `SUPER+SHIFT+Q` | Shutdown / exit Hyprland |

### Screenshots

| Key | Action |
|---|---|
| `SUPER+S` | Screenshot a selected region |
| `SUPER+SHIFT+S` | Screenshot the active window |
| `SUPER+SHIFT+Space` | Screenshot the monitor under the cursor |

### Windows

| Key | Action |
|---|---|
| `SUPER+Q` | Close active window |
| `SUPER+P` | Toggle pseudotiling |
| `SUPER+SHIFT+T` | Toggle floating |
| `SUPER+SHIFT+F` | Toggle fullscreen (maximized) |
| `SUPER + ←/→/↑/↓` | Move focus between windows |
| `SUPER+SHIFT + ←/→/↑/↓` | Move the active window |
| `SUPER + mouse drag (LMB)` | Move a window |
| `SUPER + mouse drag (RMB)` | Resize a window |

### Workspaces

| Key | Action |
|---|---|
| `SUPER + [0–9]` | Switch to workspace 1–10 |
| `SUPER+SHIFT + [0–9]` | Move active window to workspace 1–10 |
| `SUPER + scroll up/down` | Cycle through workspaces |
| 3-finger horizontal swipe (touchpad) | Switch workspaces |

### Media & brightness

| Key | Action |
|---|---|
| Volume Up / Down / Mute | Adjust or mute system volume |
| Mic Mute | Mute microphone |
| Brightness Up / Down | Adjust screen brightness |
| `Ctrl+↑` / `Ctrl+↓` | Adjust screen brightness via keyboard |
| Media Next / Prev / Play-Pause | Control media playback |

---

## 🎨 Look & Feel Summary

| Setting | Value |
|---|---|
| Gaps | 5px inner, 10px outer |
| Border size | 3px |
| Active border | Gradient — cyan → green, 45° angle |
| Rounding | 10px |
| Shadows | Enabled |
| Blur | Disabled |
| Layout | `dwindle` (with split preservation) |
| Cursor theme | Bibata-Modern-Ice, size 24 |
| Wallpaper fit | Cover |

---

## 🩺 Troubleshooting

| Problem | Fix |
|---|---|
| `hyprland.lua` not recognized / config doesn't load | Your Hyprland build may not support Lua configs yet — check the [Lua config wiki page](https://wiki.hypr.land/Configuring/Start/) and Hyprland version |
| Wallpaper doesn't show | Confirm the file exists at the path in `hyprpaper.conf`, and monitor names match `hyprctl monitors` output |
| Both a static and animated/default wallpaper appear | `wpaperd` and `hyprpaper` are both running — stop one (see the warning above) |
| Cursor doesn't change | Bibata-Modern-Ice isn't installed — install it or change the theme name in the autostart line |
| Screenshot binds do nothing | `hyprshot` isn't installed |
| Clipboard history bind does nothing | `cliphist` and/or `wl-clipboard` aren't installed, or clipboard history isn't running |
| Keyboard layout switch doesn't work | Confirm both `us` and `ara` layouts are available on your system |
| JetBrains binds fail | Toolbox scripts don't exist at the hardcoded path — install JetBrains Toolbox or update/remove the binds |

---

## 🙌 Contributing / Feedback

This is a personal setup shared for others to learn from or adapt. Feel free to open an issue or PR if you spot something broken or have a suggestion.
