# Neovim Config — Update Path (Helix Migration Notes)

A review of the current config against what Helix provided natively.
Gaps, suggestions, and caveats — roughly ordered by priority.

---

## What's Already Solid

- **Lazy.nvim** — good plugin manager choice, lockfile present
- **Mason + mason-lspconfig + nvim-lspconfig** — correct 0.11 setup using `vim.lsp.config` / `vim.lsp.enable`
- **nvim-cmp stack** — LSP + snippets + Copilot all wired in
- **Telescope** — replaces Helix's file/symbol picker well
- **Which-key** — space-menu mirrors Helix's `<space>` menu
- **Multiple cursors** — covers Helix's `C` (add cursor below)
- **Custom theme** — automata_night ported from Helix correctly
- **Treesitter** — pinned due to 0.11 breakage (see caveat below)

---

## Critical Gaps (Helix Did These Natively)

### 1. Git Gutter Signs — `gitsigns.nvim`
Helix shows `+`, `~`, `-` in the sign column for added/changed/deleted lines.
Your config has a `SignColumn` in the theme but nothing writes to it.

```lua
{
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add    = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
        end
        map("]h", gs.next_hunk,        "Next hunk")
        map("[h", gs.prev_hunk,        "Prev hunk")
        map("<leader>hs", gs.stage_hunk,   "Stage hunk")
        map("<leader>hr", gs.reset_hunk,   "Reset hunk")
        map("<leader>hp", gs.preview_hunk, "Preview hunk")
        map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    })
  end,
}
```

Also add `<leader>g` group to which-key for git actions.

---

### 2. Auto-pairs — `nvim-autopairs`
Helix automatically closes `(`, `[`, `{`, `"`, etc. Nothing in the config does this.

```lua
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    autopairs.setup({ check_ts = true })
    -- Wire into cmp so accepted completions also get pairs closed
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
```

---

### 3. Surround — `nvim-surround`
Helix uses `ms` (add surround), `mr` (replace surround), `md` (delete surround).
Neovim has no built-in equivalent.

```lua
{
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup()
  end,
}
```

Default binds: `ys<motion><char>` add, `cs<old><new>` change, `ds<char>` delete.
These are vim-style rather than Helix-style but are the standard.

---

### 4. Treesitter Textobjects — `nvim-treesitter-textobjects`
Helix has built-in textobjects: `maf` (function), `mac` (class), `maa` (argument).
Nothing in your config provides this.

```lua
{
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        },
      },
    })
  end,
}
```

Note: this uses the older `require("nvim-treesitter.configs").setup` API. With the pinned treesitter commit this is fine.

---

### 5. Jump Navigation — `flash.nvim`
Helix has `gw` for word-level jump navigation. Flash is the closest Neovim equivalent.

```lua
{
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash jump" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,  desc = "Remote flash" },
  },
}
```

Warning: `s` is currently unbound in your config so this is a clean slot.

---

### 6. Indent Guides — `indent-blankline.nvim`
Helix renders indent guides by default. IBL is the standard replacement.

```lua
{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufReadPre",
  config = function()
    require("ibl").setup({
      indent = { char = "▏" },
      scope  = { enabled = true },
    })
  end,
}
```

---

### 7. Statusline — `lualine.nvim`
Helix has a rich statusline (mode, file, LSP status, git branch, diagnostics).
Your config has `showmode = false` but no statusline plugin — this means the built-in blank statusline is shown. Lualine is the standard fix.

```lua
{
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",  -- or wire your automata_night palette in manually
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
```

To fully match the automata_night colours you'd pass a custom `theme` table using `M.palette` values from `lua/themes/automata_night.lua`.

---

## Quality-of-Life Gaps

### 8. LSP Progress Indicator — `fidget.nvim`
Helix shows LSP indexing status in the statusline. Without it you can't tell if
`gopls` or `rust_analyzer` is still loading.

```lua
{
  "j-hui/fidget.nvim",
  event = "LspAttach",
  config = function()
    require("fidget").setup({
      notification = { window = { winblend = 0 } },
    })
  end,
}
```

---

### 9. Better Diagnostics Panel — `trouble.nvim`
`<leader>dl` uses `telescope.builtin.diagnostics` which is adequate but Trouble
gives a persistent, navigable panel.

```lua
{
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>dq", "<cmd>Trouble diagnostics toggle<CR>",    desc = "Diagnostics (project)" },
    { "<leader>dQ", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Diagnostics (buffer)" },
  },
  config = function()
    require("trouble").setup()
  end,
}
```

---

### 10. External Formatter — `conform.nvim`
Currently `<leader>lf` calls `vim.lsp.buf.format`. For languages where the LSP
formatter is poor or absent (Lua, shell scripts, Markdown, Terraform) you want
an external formatter layer.

```lua
{
  "stevearc/conform.nvim",
  event = "BufWritePre",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua        = { "stylua" },
        go         = { "goimports", "gofmt" },
        rust       = { "rustfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        markdown   = { "prettier" },
        sh         = { "shfmt" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms   = 500,
      },
    })
    -- Override <leader>lf to use conform
    vim.keymap.set("n", "<leader>lf", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format (conform)" })
  end,
}
```

These formatters also need to be available on `$PATH` — install via Mason where
possible (`MasonInstall stylua prettier shfmt`).

---

### 11. Bufferline — `bufferline.nvim`
Helix shows open buffers in a tab-like bar at the top. Currently only `<S-h>`/
`<S-l>` cycle buffers blindly.

```lua
{
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        separator_style     = "thin",
        show_buffer_close_icons = false,
        show_close_icon     = false,
        diagnostics         = "nvim_lsp",
      },
    })
  end,
}
```

---

### 12. Colour Highlighting — `nvim-highlight-colors`
Helix renders CSS colours inline. Useful given `cssls` is already configured.

```lua
{
  "brenoprata10/nvim-highlight-colors",
  event = "BufReadPre",
  config = function()
    require("nvim-highlight-colors").setup({
      render = "background",
    })
  end,
}
```

---

### 13. TODO Comment Highlighting — `todo-comments.nvim`
Helix doesn't do this, but it's a natural complement to the existing diagnostic
highlighting and the `whitespace` comment colour in the theme.

```lua
{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPre",
  config = function()
    require("todo-comments").setup()
  end,
  keys = {
    { "<leader>dt", "<cmd>TodoTrouble<CR>", desc = "TODO list" },
  },
}
```

---

## Existing Issues / Things to Revisit

### `x` remap breaks default delete-char
```lua
map("n", "x", "V", { desc = "Select current line" })
```
This remaps `x` (delete char under cursor) to line-visual. The Helix muscle memory
for `x` = select line is understandable, but it means `x` no longer deletes a
character in normal mode. `dl` is the vim equivalent.

If you keep this remap, also consider binding `X` to something useful since it
currently does nothing meaningful in your workflow.

---

### Treesitter commit pin may be stale
`plugins/init.lua` pins `commit = "90cd6580"` but `lazy-lock.json` records
`c82bf96f`. These are different commits — the lock appears to have drifted.
Run `:Lazy restore` to re-pin to the lock, or `:Lazy update nvim-treesitter`
and re-pin to whatever works on your Neovim version.

The comment says "last commit before nvim 0.11 support was dropped". As of Neovim
0.11, the treesitter rewrite API (`require("nvim-treesitter").install(...)` +
`vim.treesitter.start()`) should work with the latest treesitter main. Worth
testing without the pin.

---

### `telescope.nvim` is pinned to `0.2.1` (2023)
The tag `0.2.1` is old. Telescope HEAD is stable and actively maintained.
Remove the `tag = "0.2.1"` line and let Lazy use the latest. The
`telescope-fzf-native` and `telescope-file-browser` extensions have likely
had fixes since then.

---

### No `cmp-cmdline` — command-line completion is bare
nvim-cmp can complete `/` (search) and `:` (commands). Worth adding:

```lua
-- Inside the nvim-cmp config function, after cmp.setup({...}):
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = "path" } },
    { { name = "cmdline" } }
  ),
})
```

Add `"hrsh7th/cmp-cmdline"` to the nvim-cmp `dependencies` list.

---

### No terminal integration
Helix opens a terminal with `<space>t` (or similar). Nothing in the config
provides this. `toggleterm.nvim` is the standard solution:

```lua
{
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = { { "<C-\\>", desc = "Toggle terminal" } },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-\>]],
      direction    = "float",
      float_opts   = { border = "rounded" },
    })
  end,
}
```

---

## Nice-to-Have (Lower Priority)

| Plugin | Purpose |
|--------|---------|
| `HiPhish/rainbow-delimiters.nvim` | Coloured matching brackets — works with treesitter |
| `NeogitOrg/neogit` | Full git TUI (like Magit) — complement to gitsigns |
| `mfussenegger/nvim-dap` + `rcarriga/nvim-dap-ui` | Debugger — Helix has DAP support |
| `nvim-telescope/telescope-ui-select.nvim` | Routes `vim.ui.select` calls through Telescope |
| `rmagatti/auto-session` | Persist/restore sessions per working directory |
| `folke/noice.nvim` | Replaces command-line, messages, and popups with cleaner UI |

---

## Suggested File Structure Expansion

The config works but everything is in `lua/plugins/init.lua`. As more plugins
are added this becomes unwieldy. Consider splitting:

```
lua/
  core/
    options.lua
    keymaps.lua
    autocmds.lua        ← pull autocmds out of plugin configs
  plugins/
    init.lua            ← just the lazy bootstrap + require() list
    ui.lua              ← lualine, bufferline, indent-blankline, colorizer
    lsp.lua             ← mason, mason-lspconfig, nvim-lspconfig
    completion.lua      ← nvim-cmp, luasnip, copilot
    editor.lua          ← autopairs, surround, flash, gitsigns, comment
    treesitter.lua      ← nvim-treesitter + textobjects
    tools.lua           ← telescope, neo-tree, trouble, toggleterm, conform
  themes/
    automata_night.lua
```

Lazy.nvim supports this pattern:
```lua
require("lazy").setup("plugins", { ... })
```
When given a string it auto-imports every `.lua` file in `lua/plugins/`.
