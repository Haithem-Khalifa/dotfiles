# Arch Linux + Ghostty + Hyprland Terminal Setup Guide

A step-by-step installation and setup guide for building a modern terminal development environment on **Arch Linux** using **Ghostty**, **Zsh**, **Powerlevel10k**, modern CLI replacements (`eza`, `bat`, `zoxide`, `yazi`, `thefuck`), and **fzf**.

---

## 1. Install & Set Ghostty as Default Terminal

### 1.1 Install Ghostty

Ghostty can be installed from the official repositories (or via the AUR if you prefer the git development branch):

```bash
# Official repository
sudo pacman -S --needed ghostty

# Or via an AUR helper
yay -S ghostty-git
# OR
paru -S ghostty-git
```

### 1.2 Set Ghostty as Default Terminal

#### Under Hyprland

Open your Hyprland configuration file:

```bash
nvim ~/.config/hypr/hyprland.conf
```

Find the terminal variable definition and update it:

```ini
$terminal = ghostty
```

Make sure your terminal launch keybinding uses this variable:

```ini
bind = $mainMod, RETURN, exec, $terminal
```

#### System-Wide (Default Terminal Utility)

Set the default terminal environment variable in your session configuration (e.g., `~/.zshenv` or `/etc/environment`):

```bash
sudo nvim /etc/environment
```

Add the following line:

```bash
TERMINAL=ghostty
```

---

## 2. Install Nerd Font & Configure Ghostty

### 2.1 Install JetBrains Mono Nerd Font

A monospaced Nerd Font ensures prompt glyphs, icons, and powerline segments render without overlapping:

```bash
sudo pacman -S --needed ttf-jetbrains-mono-nerd
```

### 2.2 Ghostty Configuration File Path

Create or edit your Ghostty configuration file:

- **Configuration file path:** `~/.config/ghostty/config`

```bash
mkdir -p ~/.config/ghostty
nvim ~/.config/ghostty/config
```

*(Add your font definitions, padding, palette colors, and shell commands here.)*

---

## 3. Package Installation

### 3.1 Core CLI Packages & Shell Plugins

Install Zsh and the modern command-line tool replacements from the official Arch repositories:

```bash
sudo pacman -S --needed \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  fzf \
  fd \
  bat \
  eza \
  zoxide \
  yazi \
  thefuck \
  git \
  curl
```

### 3.2 Powerlevel10k Theme

Install the Powerlevel10k prompt theme using your preferred method.

#### Option A: AUR (Recommended)

```bash
yay -S zsh-theme-powerlevel10k-git
# OR
paru -S zsh-theme-powerlevel10k-git
```

- **Installed Theme Path:** `/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme`

#### Option B: Git Clone

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
```

- **Installed Theme Path:** `~/.powerlevel10k/powerlevel10k.zsh-theme`

---

## 4. Helper Repositories

### 4.1 Clone `fzf-git.sh`

Clone `fzf-git.sh` into your home directory to enable fuzzy Git keybindings:

```bash
git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh
```

- **Script Path:** `~/fzf-git.sh/fzf-git.sh`

---

## 5. Zsh Configuration File Path

Open your main Zsh configuration file:

- **Configuration file path:** `~/.zshrc`

```bash
nvim ~/.zshrc
```

*(Add your autocompletion settings, history rules, plugin sources, FZF options, tool init hooks, and aliases here.)*

---

## 6. Set Zsh as Default User Shell

### 6.1 Change User Shell

Update your login shell in the system account database:

```bash
chsh -s /usr/bin/zsh
```

### 6.2 Verify the Change

Check that your user record reflects `/usr/bin/zsh`:

```bash
getent passwd $USER
```

---

## 7. Apply Changes & First Run

1. **Log out of your Hyprland session** and log back in (or reboot) to apply the new system-wide `$SHELL` variable:

   ```bash
   hyprctl dispatch exit
   ```

2. Launch **Ghostty**.

3. The **Powerlevel10k configuration wizard** will start automatically. Complete the prompts to generate your theme configuration.
   - **Generated P10k Configuration Path:** `~/.p10k.zsh`
   - To re-run the prompt setup at any point later:

     ```bash
     p10k configure
     ```

---

## 8. CLI Tools Overview & Shortcut Cheatsheet

### `eza` (Modern `ls` Replacement)

- **What it does:** Displays directory contents with file icons, Git status indicators, and color-coded metadata.
- **Common Commands & Aliases:**
  - `ls` → Standard file list with icons.
  - `ll` → Detailed list view (`eza -lah --icons=always`) showing permissions, file size, modification dates, and hidden files.
  - `lt` → Recursive tree view (`eza --tree --level=2 --icons=always`).

### `bat` (Modern `cat` Replacement)

- **What it does:** File viewer that adds syntax highlighting, Git modification indicators in the gutter, line numbers, and automatic paging.
- **Common Commands & Aliases:**
  - `cat <filename>` → Syntax-highlighted file dump without opening an editor.
  - `bat <filename>` → Paginated view (press `q` to exit, `/` to search within the file).

### `zoxide` (Smarter `cd`)

- **What it does:** Tracks your most frequently and recently used directories ("frecency") so you can jump anywhere without typing full paths.
- **How to use:**
  - `z <partial_name>` → Jumps directly to the best matching directory (e.g., `z proj` jumps to `~/code/my-project`).
  - `zi` → Interactive directory picker powered by `fzf`.

### `yazi` (Terminal File Manager)

- **What it does:** Fast, terminal-based asynchronous file manager with file previews.
- **How to use:**
  - `y` → Launches Yazi (using the wrapper function to change your shell directory to the selected folder upon exit).
- **Keybindings inside Yazi:**
  - `h` / `j` / `k` / `l` → Navigate left (parent folder), down, up, right (enter folder / preview).
  - `Space` → Select a file or folder.
  - `y` → Copy (yank).
  - `x` → Cut.
  - `p` → Paste.
  - `d` → Move to trash.
  - `q` → Quit and jump the current shell to the active folder.

### `thefuck` (CLI Auto-Corrector)

- **What it does:** Analyzes your previous command error and automatically suggests or applies the fixed command.
- **How to use:**
  - When a command fails or you mistype a flag (e.g., `pacman -S git` fails because it needs `sudo`), type:

    ```bash
    fuck
    ```

  - Press `Enter` to confirm the corrected command or `Ctrl + C` to abort.

### `fzf` & `fzf-git.sh` (Fuzzy Finder Shortcuts)

- **What it does:** Interactive fuzzy search filter for files, command history, and Git branches.
- **General Terminal Shortcuts:**
  - `Ctrl + T` → Fuzzy search files and folders from the current path; inserts the selected file path onto your command line.
  - `Alt + C` → Fuzzy search subdirectories; immediately `cd`s into the selected directory.
  - `Ctrl + R` → Fuzzy search your command history.
- **Git Shortcuts (`fzf-git.sh`):**
  - `Ctrl + G` then `B` → Fuzzy search and checkout Git **branches**.
  - `Ctrl + G` then `H` → Fuzzy search commit **hashes/history**.
  - `Ctrl + G` then `F` → Fuzzy search tracked/modified **files**.
  - `Ctrl + G` then `S` → Fuzzy search Git **status**.

### Zsh Navigation & Autosuggestions

- **Up Arrow (`↑`) / Down Arrow (`↓`):** Filters history by matching whatever you have already typed on the prompt line.
- **Right Arrow (`→`) or `End`:** Accepts the faint gray autosuggestion completion offered by `zsh-autosuggestions`.
- **`Tab`:** Triggers the standard Zsh autocompletion menu.
