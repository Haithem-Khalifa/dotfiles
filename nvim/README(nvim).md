# Neovim 0.12 IDE Configuration

A modular, full-featured IDE configuration for Neovim 0.12+. Optimized for back-end software engineering (Java 25, Spring Boot, C++) and basic front-end development (HTML, CSS, JS). Built specifically for Wayland compositors (Hyprland) on Arch Linux.

---

## 🛠️ Phase 1: System Prerequisites

Neovim and its package managers rely on system-level toolchains to compile parsers, attach language servers, and sync with the Wayland clipboard.

### 1. Arch Linux Packages

Install the required compilers, Node runtime, clipboard utilities, and dependencies:

```bash
sudo pacman -Syu --needed \
    base-devel \
    git \
    curl \
    unzip \
    tar \
    ripgrep \
    fd \
    clang \
    nodejs \
    npm \
    jdk25-openjdk \
    wl-clipboard \
    tree-sitter-cli
```

*(Note: Ensure your terminal uses a Nerd Font like `JetBrainsMono Nerd Font` for UI icons).*

### 2. Java 25 Environment

Set Java 25 as the default runtime environment:

```bash
sudo archlinux-java set java-25-openjdk
```

### 3. Spring Boot Lombok Agent

To prevent diagnostic errors on Spring Boot annotations (`@Getter`/`@Setter`), download the Lombok agent to your local share directory. The Java LSP is configured to look for it here:

```bash
mkdir -p ~/.local/share/java
curl -Lo ~/.local/share/java/lombok.jar https://projectlombok.org/downloads/lombok.jar
```

---

## 🚀 Phase 2: Clean Slate & Repository Setup

Clean your Neovim cache to prevent conflicts with older setups, then clone this repository:

```bash
# Backup existing configuration if needed
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Clean stale state and cache files
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Clone this repository
git clone <YOUR_GITHUB_REPO_URL_HERE> ~/.config/nvim
```

---

## 📂 Phase 3: Configuration Structure

This repository provides all needed configuration files pre-configured. Their roles are:

* **`init.lua`**: Global editor settings (tabs, line numbers, Wayland clipboard synchronization) and `lazy.nvim` bootstrapping.
* **`lua/plugins/ui.lua`**: Color scheme (`tokyonight`) and fuzzy finder (`telescope.nvim`).
* **`lua/plugins/treesitter.lua`**: Tree-sitter configuration for native syntax highlighting on Neovim 0.12.
* **`lua/plugins/cmp.lua`**: Code completion engine, snippet integration (`LuaSnip`), and menu keybindings.
* **`lua/plugins/lsp.lua`**: Language server configurations for C++, HTML, CSS, and JS using the modern `vim.lsp.config` API.
* **`lua/plugins/formatting.lua`**: Auto-formatting engine (`conform.nvim`) for `clang-format`, `google-java-format`, and `prettier`.
* **`lua/plugins/neotree.lua`**: Side-docked file tree explorer with Git status and file icons.
* **`lua/plugins/lualine.lua`**: Statusline showing Git branches, diagnostics, and file encoding.
* **`lua/plugins/dap.lua`**: Debug Adapter Protocol (DAP) client and UI integration.
* **`lua/plugins/java.lua`**: Lazy-load declaration for `nvim-jdtls`.
* **`ftplugin/java.lua`**: The Spring Boot engine. Manages project workspace caching, injects the Lombok `-javaagent`, attaches DAP bundles, and starts `jdtls`.

---

## ⚙️ Phase 4: First Launch & Mason Installs

1. **Launch Neovim:**

   ```bash
   nvim
   ```

   `lazy.nvim` will automatically bootstrap, download all plugins, and compile Tree-sitter parsers.

2. **Install Formatters & Debuggers:**

   Open Mason inside Neovim by typing `:Mason`. Press `/` to search and `i` to install:
   * `java-debug-adapter` (Java/Spring Boot debugger)
   * `google-java-format` (Java code formatter)
   * `prettier` (HTML, CSS, JS formatter)

---

## ⌨️ Phase 5: Keybindings Reference

### File Navigation & UI

| Keybinding | Action |
| --- | --- |
| `<Space> + e` | Toggle Neo-tree file explorer |
| `<Space> + o` | Focus cursor on Neo-tree |
| `<Space> + ff` | Telescope: Find files |
| `<Space> + fg` | Telescope: Live grep (search text inside project) |
| `<Space> + fb` | Telescope: Switch open buffers |

### LSP & Refactoring (Active in Code Buffers)

| Keybinding | Action |
| --- | --- |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<Space> + rn` | Rename symbol project-wide |
| `<Space> + ca` | Code actions (quick fixes, imports) |
| `gr` | Find references |
| `[d` / `]d` | Jump to previous / next diagnostic warning |
| `<Space> + mp` | Format current buffer |

### Java Specific (JDTLS)

| Keybinding | Action |
| --- | --- |
| `<Space> + jo` | Organize imports |
| `<Space> + jv` | Extract variable |
| `<Space> + jc` | Extract constant |

### Debugging (DAP)

| Keybinding | Action |
| --- | --- |
| `<F5>` | Start debug session / Continue |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<Space> + b` | Toggle Breakpoint |
| `<Space> + B` | Set Conditional Breakpoint |
| `<Space> + du` | Toggle Debugger UI panels |

### Autocompletion (Insert Mode)

| Keybinding | Action |
| --- | --- |
| `<Tab>` | Select next completion / expand snippet |
| `<Enter>` | Confirm completion selection |
| `<Ctrl> + Space` | Manually trigger completion popup |
