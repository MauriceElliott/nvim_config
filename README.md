# Neovim Configuration - Helix-Inspired DevOps Setup

Modern Neovim configuration written in Fennel, inspired by Helix editor with full DevOps tooling support.

## ✨ Features

- **Fennel-based configuration** - Entire config written in Fennel
- **Helix-inspired keybindings** - Familiar workflow from Helix
- **Custom Automata themes** - Ported from your Helix themes (night & day)
- **Fuzzy search** - Telescope with fzf (Spotlight-like)
- **LSP Integration** - Full language server support with Mason
- **GitHub Copilot** - AI pair programming
- **DevOps tooling** - Kubernetes, Helm, Terraform, YAML, Docker, etc.

## 🚀 Quick Start

```bash
nvim
```

First launch will automatically:
1. Bootstrap hotpot.nvim and lazy.nvim
2. Install all plugins
3. Install LSP servers via Mason (may take a few minutes)

## ⌨️ Key Bindings (Helix-Inspired)

**Leader:** `Space`

### Essential
- `<leader>f` - Find files
- `<leader>/` - Search in files  
- `<leader>e` - File explorer
- `<leader>w` - Save
- `<leader>q` - Quit
- `<leader><space>` - Buffer list

### LSP
- `gd` - Go to definition
- `gr` - References
- `K` - Hover documentation
- `<leader>ca` - Code action
- `<leader>rn` - Rename
- `[d` / `]d` - Navigate diagnostics
- `<leader>F` - Format document

### Editing
- `<M-j>` / `<M-Down>` - Move line down
- `<M-k>` / `<M-Up>` - Move line up
- `gcc` - Toggle line comment
- `jk` or `jj` - Exit insert mode

### Navigation
- `<C-h/j/k/l>` - Window navigation
- `<S-h/l>` - Previous/next buffer
- `s` - Flash jump

## 🎨 Themes

- **automata_night** (default) - Dark theme with warm tones
- **automata_day** - Light theme

Switch: `:colorscheme automata_day`

## 📦 Plugins

- **hotpot.nvim** - Fennel support
- **lazy.nvim** - Plugin manager
- **telescope.nvim** - Fuzzy finder
- **nvim-treesitter** - Syntax highlighting
- **nvim-lspconfig** + **mason.nvim** - LSP
- **nvim-cmp** - Completion
- **copilot.lua** - GitHub Copilot
- **conform.nvim** - Formatting
- **nvim-lint** - Linting
- **neo-tree.nvim** - File explorer
- **lualine.nvim** - Statusline
- **bufferline.nvim** - Buffer tabs
- **which-key.nvim** - Keybinding helper
- **gitsigns.nvim** - Git integration
- And more...

## 🛠️ LSP Servers (Auto-installed)

- lua_ls, yamlls, terraformls, helm_ls
- dockerls, bashls, jsonls, marksman

Install more via `:Mason`

## 📁 File Structure

```
~/.config/nvim/
├── init.lua              # Bootstrap
├── fnl/config/           # Core config (Fennel)
├── fnl/plugins/          # Plugin specs (Fennel)
├── colors/               # Custom themes
└── lua/                  # Compiled (auto-generated)
```

## 🔧 Customization

**Change theme:** Edit `fnl/plugins/colorscheme.fnl`  
**Add LSP servers:** Edit `fnl/plugins/lsp.fnl`  
**Modify keybindings:** Edit `fnl/config/keymaps.fnl`

## 💡 Tips

- `:checkhealth` - Verify setup
- `:Lazy` - Manage plugins
- `:Mason` - Manage LSP servers
- `<leader>?` - Show keybindings (which-key)
- Auto-format on save for Terraform, YAML, JSON

## 🎯 DevOps Features

- **Kubernetes:** YAML LSP with K8s schema validation
- **Terraform:** terraform-ls + auto-format on save
- **Helm:** Dedicated helm-ls support
- **Docker:** Dockerfile LSP + hadolint linting

---

**Backup:** Previous config saved to `~/.config/nvim.backup.TIMESTAMP`

Enjoy! 🚀
