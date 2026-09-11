# Neovim Configuration

A modern, fast, and modular Neovim configuration built with Lua and managed via [`lazy.nvim`](https://github.com/folke/lazy.nvim). Optimized for software engineering workflows including Java, C/C++, web development, and competitive programming.

---

## ✨ Features

- ⚡ Fast startup with lazy-loaded plugins via `lazy.nvim`
- 🧠 Full LSP support (Java, C/C++, HTML/CSS/JS) with Mason-managed servers
- 🐞 Integrated debugging (DAP) with a full UI, breakpoints, and step controls
- 🌳 Tree-sitter powered syntax highlighting and indentation
- 🔍 Fuzzy finding with Telescope
- 🗂️ File tree navigation with Neo-tree
- 🎨 Tokyonight theme with a clean, informative statusline
- ✂️ Autocompletion, snippets, autopairs, and on-save formatting
- 🔧 Git integration with inline hunk previews and blame

---

## 📁 Structure Overview

```text
~/.config/nvim/
├── ftplugin/
│   └── java.lua           # Eclipse JDTLS & Java DAP configuration
├── lua/
│   └── plugins/
│       ├── autopairs.lua   # Auto-closing quotes & brackets
│       ├── cmp.lua         # Autocompletion & snippet engine
│       ├── dap.lua         # Debug Adapter Protocol & UI
│       ├── dressing.lua    # Floating UI improvements
│       ├── formatting.lua  # Code formatting (conform.nvim)
│       ├── gitsigns.lua    # Git gutter signs & hunk actions
│       ├── java.lua        # nvim-jdtls plugin declaration
│       ├── lsp.lua         # LSP client & Mason installer
│       ├── lualine.lua     # Statusline configuration
│       ├── neotree.lua     # File tree sidebar
│       ├── surround.lua    # Delimiter surround operator
│       ├── treesitter.lua  # Syntax highlighting & AST parsing
│       ├── trouble.lua     # Diagnostics & references drawer
│       ├── ui.lua          # Tokyonight colorscheme & Telescope
│       └── which-key.lua   # Keybinding hint popups
├── init.lua                # Options, leader keys & lazy.nvim bootstrap
└── lazy-lock.json          # Locked plugin commit hashes
```

---

## ✅ Prerequisites

Install these **before** cloning this config. Click each tool for install instructions for your OS.

| Tool | Why it's needed | Install |
|---|---|---|
| **Neovim ≥ 0.9** | The editor itself | [neovim.io/install](https://neovim.io/) — macOS: `brew install neovim`, Ubuntu/Debian: `sudo apt install neovim` (or build from source for the latest version), Windows: `winget install Neovim.Neovim` |
| **Git** | Cloning this repo & plugin management | macOS: `brew install git`, Ubuntu/Debian: `sudo apt install git`, Windows: [git-scm.com](https://git-scm.com/downloads) |
| **A Nerd Font** | Icons in Neo-tree, Telescope, statusline, etc. | Download one from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) (e.g. `JetBrainsMono Nerd Font`, `FiraCode Nerd Font`), install it, then set it as your terminal's font |
| **ripgrep (`rg`)** | Powers Telescope's live grep | macOS: `brew install ripgrep`, Ubuntu/Debian: `sudo apt install ripgrep`, Windows: `winget install BurntSushi.ripgrep.MSVC` |
| **A C compiler** (`gcc`/`clang`) | Required by Tree-sitter to compile parsers | macOS: install Xcode Command Line Tools (`xcode-select --install`), Ubuntu/Debian: `sudo apt install build-essential`, Windows: install [MSVC Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) or use WSL |
| **Node.js & npm** | Needed by several LSP servers/formatters (`ts_ls`, `emmet_language_server`, `prettier`) | [nodejs.org](https://nodejs.org/) or a version manager like `nvm` |
| **JDK 17+** | Required for Java language support and debugging | macOS: `brew install openjdk@17`, Ubuntu/Debian: `sudo apt install openjdk-17-jdk`, Windows: [Adoptium Temurin](https://adoptium.net/) |
| **A Nerd-Font-enabled terminal** | Any modern terminal works (Windows Terminal, iTerm2, Alacritty, Kitty, WezTerm) — just make sure it's set to use the Nerd Font you installed | — |

> 💡 Run `nvim --version` and `git --version` after installing to confirm they're on your `PATH`.

---

## 🚀 Installation

1. **Back up any existing Neovim configuration** (if you have one):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```
   On Windows (PowerShell), the config lives at `~\AppData\Local\nvim` instead.

2. **Clone this repository** into the Neovim config directory:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Launch Neovim.** On first launch, `lazy.nvim` bootstraps itself automatically and installs every plugin listed in `lua/plugins/`:
   ```bash
   nvim
   ```
   Wait for the Lazy install window to finish, then restart Neovim.

4. **Install language servers, formatters, and debug adapters via Mason.** Open Neovim and run:
   ```vim
   :Mason
   ```
   The servers configured in `lua/plugins/lsp.lua` (`clangd`, `html`, `cssls`, `ts_ls`, `emmet_language_server`, `jdtls`) plus `google-java-format`, `clang-format`, `prettier`, and the Java debug adapters should install automatically. If any show as "not installed," select them in the Mason UI and press `i`.

5. **Verify everything works:**
   - Run `:checkhealth` and resolve any reported issues (missing compilers, missing Nerd Font glyphs, etc.).
   - Open a `.java`, `.c`, or `.js` file and confirm LSP is attached — try `K` for hover docs or `gd` to go to definition.
   - Press `<F5>` in a Java file to confirm the debugger launches.

6. **(Optional) Set your terminal font** to the Nerd Font you installed if icons appear as boxes or question marks.

### Uninstalling

To remove the config and start fresh:
```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

---

## 🩺 Troubleshooting

| Problem | Fix |
|---|---|
| Icons show as boxes/`?` | Your terminal isn't using a Nerd Font — install one and set it in your terminal's preferences |
| Tree-sitter parsers fail to install | Make sure a C compiler is installed and on your `PATH` |
| Java LSP/DAP not working | Confirm JDK 17+ is installed and `JAVA_HOME` is set correctly |
| `ts_ls`/`prettier`/`emmet` fail to install via Mason | Make sure `node` and `npm` are installed and on your `PATH` |
| Telescope live grep returns nothing | Install `ripgrep` (`rg --version` to check) |
| Plugins don't load on first launch | Run `:Lazy sync` manually, then restart Neovim |

---

## ⌨️ Keybindings

**Leader key:** `<Space>` (also used as `<localleader>`)

### Plugin Management

| Key | Action |
|---|---|
| `:Lazy` | Open the Lazy UI dashboard |

### File Navigation & Search

| Key | Action |
|---|---|
| `<leader>e` | Toggle file explorer drawer (Neo-tree) |
| `<leader>o` | Focus inside file tree |
| `<leader>ff` | Search files by name in current project |
| `<leader>fg` | Live grep search file contents |
| `<leader>fb` | List and filter active buffers |

### LSP & Diagnostics

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover documentation popup |
| `gr` | Find references across files |
| `<leader>rn` | Rename symbol project-wide |
| `<leader>ca` | Show LSP code actions |
| `[d` / `]d` | Jump to previous / next diagnostic |
| `<leader>xx` | Toggle Project Diagnostics panel (Trouble) |
| `<leader>xX` | Toggle Current Buffer Diagnostics panel |
| `<leader>cs` | Toggle Document Symbols panel |
| `<leader>cl` | Toggle LSP Definitions / References panel |
| `<leader>xQ` | Toggle Quickfix list |
| `<leader>xL` | Toggle Location list |

### Java Development

| Key | Action |
|---|---|
| `<leader>jo` | Organize imports |
| `<leader>jv` | Extract local variable |
| `<leader>jc` | Extract constant |

### Debugging (DAP)

| Key | Action |
|---|---|
| `<F5>` | Debug: Start / Continue |
| `<F10>` | Debug: Step Over |
| `<F11>` | Debug: Step Into |
| `<F12>` | Debug: Step Out |
| `<leader>b` | Toggle line breakpoint |
| `<leader>B` | Set conditional breakpoint |
| `<leader>du` | Toggle Debugger UI drawer |

### Autocompletion & Formatting

| Key | Action |
|---|---|
| `<C-Space>` | Trigger autocompletion popup |
| `<CR>` | Confirm selection |
| `<Tab>` | Next candidate / advance snippet placeholders |
| `<C-f>` / `<C-b>` | Scroll documentation float down / up |
| `<leader>mp` | Trigger manual buffer format |

### Git & Text Objects

| Key | Action |
|---|---|
| `]h` / `[h` | Next / previous Git hunk |
| `<leader>hs` | Stage hunk under cursor |
| `<leader>hr` | Reset/discard hunk under cursor |
| `<leader>hp` | Preview hunk inline diff |
| `<leader>gb` | Blame current line |
| `ysiw"` | Add `"` around inner word |
| `cs"'` | Change surrounding `"` to `'` |
| `ds"` | Delete surrounding `"` |

---

## 🔌 Plugins

| Category | Plugin | Purpose |
|---|---|---|
| Plugin Manager | [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim) | Declarative plugin management with lazy-loading |
| UI | [`folke/tokyonight.nvim`](https://github.com/folke/tokyonight.nvim) | Colorscheme (`tokyonight-night`) |
| UI | [`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| UI | [`stevearc/dressing.nvim`](https://github.com/stevearc/dressing.nvim) | Floating UI for prompts/selections |
| Navigation | [`nvim-neo-tree/neo-tree.nvim`](https://github.com/nvim-neo-tree/neo-tree.nvim) | File tree with git status |
| Navigation | [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| Syntax | [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | AST-based highlighting & indentation |
| LSP | [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | LSP client configuration |
| LSP | [`williamboman/mason.nvim`](https://github.com/williamboman/mason.nvim) + [`mason-lspconfig.nvim`](https://github.com/williamboman/mason-lspconfig.nvim) | LSP/DAP/formatter installer |
| LSP | [`folke/trouble.nvim`](https://github.com/folke/trouble.nvim) | Diagnostics & references panel |
| Java | [`mfussenegger/nvim-jdtls`](https://github.com/mfussenegger/nvim-jdtls) | Java LSP (Eclipse JDTLS) |
| Debugging | [`mfussenegger/nvim-dap`](https://github.com/mfussenegger/nvim-dap), [`rcarriga/nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui), [`nvim-neotest/nvim-nio`](https://github.com/nvim-neotest/nvim-nio) | Debug Adapter Protocol + UI |
| Completion | [`hrsh7th/nvim-cmp`](https://github.com/hrsh7th/nvim-cmp) (+ LuaSnip, cmp-nvim-lsp, cmp-buffer, cmp-path) | Autocompletion engine |
| Completion | [`onsails/lspkind.nvim`](https://github.com/onsails/lspkind.nvim) | Codicon pictograms in completion menu |
| Editing | [`windwp/nvim-autopairs`](https://github.com/windwp/nvim-autopairs) | Auto-close brackets/quotes |
| Editing | [`kylechui/nvim-surround`](https://github.com/kylechui/nvim-surround) | Surround text-object operator |
| Formatting | [`stevearc/conform.nvim`](https://github.com/stevearc/conform.nvim) | `google-java-format`, `clang-format`, `prettier` on save |
| Git | [`lewis6991/gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim) | Gutter signs, hunk actions, blame |
| Discovery | [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim) | Keybinding hint popups |

---

## 🛠️ Supported Languages

Java · C · C++ · HTML · CSS · JavaScript · JSON · Lua · Markdown

---

## 🙌 Contributing / Feedback

This is a personal setup shared for others to learn from or adapt. Feel free to open an issue or PR if you spot something broken or have a suggestion.
