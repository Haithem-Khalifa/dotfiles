# Ghostty + Zsh Terminal Setup

A fast, modern terminal environment built on [Ghostty](https://ghostty.org/) and [Zsh](https://www.zsh.org/), with [Powerlevel10k](https://github.com/romkatv/powerlevel10k), fuzzy history/file search via [fzf](https://github.com/junegunn/fzf), smart navigation, and a set of modern CLI tool replacements (`eza`, `bat`, `zoxide`, `yazi`).

> ⚠️ **Arch Linux note:** the `.zshrc` sources plugins from Arch package paths (`/usr/share/zsh/...`). If you're on a different distro or macOS, see the [Non-Arch Linux / macOS](#-non-arch-linux--macos-adjustments) section below to adjust those lines.

---

## ✨ Features

- 🖥️ Ghostty terminal with a custom dark blue color palette and JetBrainsMono Nerd Font
- 🚀 Powerlevel10k prompt theme with instant prompt for fast shell startup
- 💡 Fish-style autosuggestions and real-time syntax highlighting
- 🔍 Fuzzy-find files, directories, and git objects with fzf (themed to match the Ghostty palette)
- 📂 Smart `cd` replacement via `zoxide` (jump to frecent directories)
- 🩹 Auto-correct mistyped commands with `thefuck`
- 🗃️ Terminal file manager (`yazi`) that `cd`s into the last visited directory on exit
- 🎨 Modern replacements for `ls` and `cat` (`eza`, `bat`) with icons
- 🧠 Deduplicated, shared shell history across sessions

---

## 📁 Files

```text
config.ghostty   # Ghostty terminal config (font, theme, colors, padding)
_zshrc           # Zsh config (rename to ~/.zshrc — plugins, aliases, tool init)
```

---

## ✅ Prerequisites

Install these **before** applying the configs.

| Tool | Why it's needed | Install |
|---|---|---|
| **Ghostty** | The terminal emulator itself | [ghostty.org/download](https://ghostty.org/download) — macOS: `brew install --cask ghostty`, Arch: `sudo pacman -S ghostty`, other Linux: see [official docs](https://ghostty.org/docs/install/binary) |
| **Zsh** | The shell these configs are written for | macOS: preinstalled, Ubuntu/Debian: `sudo apt install zsh`, Arch: `sudo pacman -S zsh` |
| **JetBrainsMono Nerd Font** | Icons in the prompt, `eza`, and fzf | Download from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) → "JetBrainsMono Nerd Font", install it, then set it in Ghostty (already set via `font-family` in the config) |
| **Powerlevel10k** | The prompt theme | Arch: `sudo pacman -S zsh-theme-powerlevel10k`, macOS/other: `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k` (then update the `source` path in `.zshrc`) |
| **zsh-autosuggestions** | Fish-style command suggestions | Arch: `sudo pacman -S zsh-autosuggestions`, macOS: `brew install zsh-autosuggestions`, others: [manual install](https://github.com/zsh-users/zsh-autosuggestions#installation) |
| **zsh-syntax-highlighting** | Real-time command syntax highlighting | Arch: `sudo pacman -S zsh-syntax-highlighting`, macOS: `brew install zsh-syntax-highlighting`, others: [manual install](https://github.com/zsh-users/zsh-syntax-highlighting#in-your-zshrc) |
| **fzf** | Fuzzy finder powering `Ctrl+T`, `Alt+C`, history search | macOS: `brew install fzf`, Ubuntu/Debian: `sudo apt install fzf`, Arch: `sudo pacman -S fzf` |
| **fd** | Fast file finder used by fzf | macOS: `brew install fd`, Ubuntu/Debian: `sudo apt install fd-find`, Arch: `sudo pacman -S fd` |
| **zoxide** | Smarter `cd` (aliased over `cd`) | macOS: `brew install zoxide`, Ubuntu/Debian: `sudo apt install zoxide`, Arch: `sudo pacman -S zoxide` |
| **thefuck** | Corrects your last mistyped command | macOS: `brew install thefuck`, Ubuntu/Debian: `sudo apt install thefuck`, Arch: `sudo pacman -S thefuck` |
| **yazi** | Terminal file manager (`y` function) | macOS: `brew install yazi`, Arch: `sudo pacman -S yazi`, others: [installation guide](https://yazi-rs.github.io/docs/installation/) |
| **eza** | Modern `ls` replacement with icons | macOS: `brew install eza`, Ubuntu/Debian: `sudo apt install eza`, Arch: `sudo pacman -S eza` |
| **bat** | Modern `cat` replacement with syntax highlighting | macOS: `brew install bat`, Ubuntu/Debian: `sudo apt install bat`, Arch: `sudo pacman -S bat` |
| **Neovim** | Aliased as `v`/`vi`/`vim` | See the separate Neovim config README, or [neovim.io](https://neovim.io/) |

### Optional

| Tool | Why it's needed | Install |
|---|---|---|
| **fzf-git.sh** | Fuzzy search git branches/commits/stashes/etc. | `git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh` |
| **Spicetify** | Spotify theming CLI (only relevant if `~/.spicetify` exists) | [spicetify.app](https://spicetify.app/docs/getting-started) |

> 💡 On Ubuntu/Debian, `fd` installs as `fdfind` — you may need to symlink it: `ln -s $(which fdfind) ~/.local/bin/fd`

---

## 🚀 Installation

1. **Install all prerequisites** from the table above.

2. **Install the Nerd Font** and confirm it's installed:
   ```bash
   fc-list | grep -i "JetBrainsMono Nerd Font"
   ```

3. **Copy the Ghostty config:**
   ```bash
   mkdir -p ~/.config/ghostty
   cp config.ghostty ~/.config/ghostty/config
   ```

4. **Copy the Zsh config** (note the filename change — the uploaded file is `_zshrc`, it needs to become `.zshrc`):
   ```bash
   cp _zshrc ~/.zshrc
   ```

5. **If not on Arch**, edit the plugin `source` lines in `~/.zshrc` to match your system's install paths — see [Non-Arch adjustments](#-non-arch-linux--macos-adjustments) below.

6. **Set Zsh as your default shell** (if it isn't already):
   ```bash
   chsh -s $(which zsh)
   ```

7. **Restart your terminal** (or open a new Ghostty window). On first launch:
   - Powerlevel10k's instant prompt will initialize.
   - If no `~/.p10k.zsh` exists yet, run `p10k configure` to generate your prompt style.

8. **Verify tool integrations work:**
   - `z <partial-dirname>` — jumps via zoxide
   - `Ctrl+T` — fzf file picker
   - `Ctrl+R` — fzf history search
   - `ll` — should list files with icons via `eza`
   - `cat somefile` — should show syntax-highlighted output via `bat`
   - `y` — opens yazi and `cd`s into the folder you exit from

---

## 🐧 Non-Arch Linux / macOS Adjustments

The original `.zshrc` sources plugins from **Arch package paths**:

```bash
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

On other systems, replace these with the paths for your install method — for example, with Homebrew on macOS:

```bash
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

Or if manually cloned into your home directory:

```bash
source ~/.powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

---

## ⌨️ Aliases & Functions

| Alias/Function | Runs | Purpose |
|---|---|---|
| `c` | `clear` | Clear the terminal |
| `cd` | `z` | Smart directory jump via zoxide |
| `ls` | `eza --icons=always` | List files with icons |
| `ll` | `eza -lah --icons=always` | Detailed list, including hidden files |
| `la` | `eza -a --icons=always` | List including hidden files |
| `lt` | `eza --tree --level=2 --icons=always` | Tree view, 2 levels deep |
| `cat` | `bat --paging=never` | Syntax-highlighted file viewer |
| `v`, `vi`, `vim` | `nvim` | Open Neovim |
| `y` | — | Opens `yazi`; on exit, `cd`s to the last directory you visited inside it |

### fzf shortcuts (via `source <(fzf --zsh)`)

| Key | Action |
|---|---|
| `Ctrl+T` | Fuzzy-find a file/directory and insert it at the cursor |
| `Ctrl+R` | Fuzzy-search shell history |
| `Alt+C` | Fuzzy-find and `cd` into a directory |
| `↑` / `↓` | Search history matching what you've typed so far |

---

## 🎨 Ghostty Configuration Summary

| Setting | Value |
|---|---|
| Font | JetBrainsMono Nerd Font Mono, size 13 |
| Shell | `/usr/bin/zsh` |
| Background | `#00111E` (dark navy) |
| Foreground | `#CBE0F0` |
| Cursor | `#47FF9C` |
| Window padding | 10px (x and y) |

If your `zsh` binary lives elsewhere (e.g. Homebrew installs to `/opt/homebrew/bin/zsh`), update the `command` line in `config.ghostty` to match `which zsh`.

---

## 🩺 Troubleshooting

| Problem | Fix |
|---|---|
| Icons show as boxes/`?` | Nerd Font not installed or not set in Ghostty — verify with `fc-list \| grep -i nerd` |
| `source <(fzf --zsh)` errors | Your fzf version is too old — update it; `--zsh` needs a recent release |
| Powerlevel10k/plugins fail to source | Path doesn't match your system — see [Non-Arch adjustments](#-non-arch-linux--macos-adjustments) |
| `thefuck --alias` errors on startup | `thefuck` isn't installed or not on `PATH` |
| `fd` not found (Ubuntu/Debian) | Package installs as `fdfind` — symlink it to `fd` (see note under Prerequisites) |
| Ghostty won't launch shell | Check the `command` path in `config.ghostty` matches your actual `zsh` location (`which zsh`) |
| `fzf-git.sh` block does nothing | It's optional — only works if cloned to `~/fzf-git.sh` |

---

## 🙌 Contributing / Feedback

This is a personal setup shared for others to learn from or adapt. Feel free to open an issue or PR if you spot something broken or have a suggestion.
