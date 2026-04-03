-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ── Dependencies ───────────────────────────────────────────────────────
  { "nvim-lua/plenary.nvim",          lazy = true },
  { "nvim-tree/nvim-web-devicons",    lazy = true },
  { "MunifTanjim/nui.nvim",           lazy = true },

  -- ── Fuzzy Finder ───────────────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.2.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          preview = {
            treesitter = false, -- use regex highlighter; new nvim-treesitter removed the configs API telescope expects
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<Esc>"] = actions.close,
            },
          },
          file_ignore_patterns = { "node_modules", ".git/" },
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
  },

  -- ── File Sidebar ───────────────────────────────────────────────────────
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style   = "rounded",
        window = {
          position = "left",
          width    = 30,
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles   = false,
            hide_gitignored = false,
          },
          follow_current_file = {
            enabled = true,
          },
        },
      })

      -- Auto-open neo-tree when nvim is opened on a directory
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            require("neo-tree.command").execute({ action = "show" })
          end
        end,
      })
    end,
  },

  -- ── Which-key ──────────────────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk     = require("which-key")
      local builtin = require("telescope.builtin")

      wk.setup({
        preset = "modern",
        delay  = 300,
      })

      -- Space-leader menu (mirrors Helix space menu)
      wk.add({
        { "<leader>f",  function()
            builtin.find_files({ hidden = true })
          end,                                                  desc = "Find files" },

        { "<leader>.",  function()
            local dir = vim.fn.expand("%:p:h")
            builtin.find_files({ cwd = dir, hidden = true })
          end,                                                  desc = "Find files (here)" },

        { "<leader>e",  "<cmd>Telescope file_browser<CR>",     desc = "Browse folders" },
        { "<leader>/",  builtin.live_grep,                     desc = "Search in project" },
        { "<leader>b",  builtin.buffers,                       desc = "Buffers" },
        { "<leader>t",  "<cmd>Neotree toggle<CR>",             desc = "Toggle file tree" },
        { "<leader>x",  "<cmd>bdelete<CR>",                    desc = "Close buffer" },

        -- LSP group
        { "<leader>l",  group = "LSP" },
        { "<leader>ld", vim.lsp.buf.definition,                desc = "Go to definition" },
        { "<leader>lD", vim.lsp.buf.declaration,               desc = "Go to declaration" },
        { "<leader>lr", vim.lsp.buf.references,                desc = "References" },
        { "<leader>lR", vim.lsp.buf.rename,                    desc = "Rename symbol" },
        { "<leader>la", vim.lsp.buf.code_action,               desc = "Code action" },
        { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
        { "<leader>lk", vim.lsp.buf.hover,                     desc = "Hover docs" },
        { "<leader>li", vim.lsp.buf.implementation,            desc = "Implementation" },

        -- Diagnostics group
        { "<leader>d",  group = "Diagnostics" },
        { "<leader>dd", vim.diagnostic.open_float,             desc = "Show diagnostic" },
        { "<leader>dl", builtin.diagnostics,                   desc = "List diagnostics" },
        { "<leader>dn", vim.diagnostic.goto_next,              desc = "Next diagnostic" },
        { "<leader>dp", vim.diagnostic.goto_prev,              desc = "Prev diagnostic" },
      })
    end,
  },

  -- ── Treesitter ─────────────────────────────────────────────────────────
  -- Pinned to last commit before nvim 0.11 support was dropped
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "90cd6580",
    build  = ":TSUpdate",
    config = function()
      -- Install parsers using the new rewrite API
      require("nvim-treesitter").install({
        "yaml", "toml", "go", "rust", "c", "cpp",
        "html", "javascript", "typescript", "json",
        "css", "bash", "lua", "vim", "vimdoc",
        "powershell",
      })

      -- Enable treesitter highlighting + indentation via FileType autocmd
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- ── LSP ────────────────────────────────────────────────────────────────
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "yamlls",
          "powershell_es",
          "taplo",
          "gopls",
          "rust_analyzer",
          "jsonls",
          "html",
          "ts_ls",
          "clangd",
          "cssls",
          -- "ols" and "sourcekit" may require manual install depending on platform
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Shared on_attach for buffer-local keybinds
      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        map("gd",    vim.lsp.buf.definition,     "Go to definition")
        map("gD",    vim.lsp.buf.declaration,    "Go to declaration")
        map("gi",    vim.lsp.buf.implementation, "Go to implementation")
        map("gr",    vim.lsp.buf.references,     "References")
        map("K",     vim.lsp.buf.hover,          "Hover docs")
        map("<C-s>", vim.lsp.buf.signature_help, "Signature help")
      end

      -- Apply capabilities + on_attach globally via nvim 0.11 native API
      vim.lsp.config("*", {
        on_attach    = on_attach,
        capabilities = capabilities,
      })

      -- Enable all servers (configs provided by nvim-lspconfig's lsp/ directory)
      vim.lsp.enable({
        "yamlls",
        "powershell_es",
        "taplo",
        "gopls",
        "rust_analyzer",
        "jsonls",
        "html",
        "ts_ls",
        "clangd",
        "cssls",
        -- "ols",      -- Odin: requires manual install
        -- "sourcekit" -- Swift: requires Xcode/Swift toolchain
      })

      -- Diagnostic display config
      vim.diagnostic.config({
        virtual_text     = true,
        signs            = true,
        underline        = true,
        update_in_insert = false,
        float            = { border = "rounded" },
      })
    end,
  },

  -- ── Completion ─────────────────────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"]   = cmp.mapping.select_prev_item(),
          ["<C-j>"]   = cmp.mapping.select_next_item(),
          ["<C-b>"]   = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]   = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]   = cmp.mapping.abort(),
          ["<Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"]    = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = "copilot",  priority = 100 },
          { name = "nvim_lsp", priority = 90 },
          { name = "luasnip",  priority = 80 },
          { name = "buffer",   priority = 50 },
          { name = "path",     priority = 40 },
        }),
        formatting = {
          format = function(entry, item)
            local source_labels = {
              copilot  = "[Copilot]",
              nvim_lsp = "[LSP]",
              luasnip  = "[Snippet]",
              buffer   = "[Buffer]",
              path     = "[Path]",
            }
            item.menu = source_labels[entry.source.name] or entry.source.name
            return item
          end,
        },
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  -- ── GitHub Copilot ─────────────────────────────────────────────────────
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- handled via copilot-cmp
        panel      = { enabled = false },
        filetypes  = {
          yaml       = true,
          markdown   = true,
          ["*"]      = true,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

}, {
  ui = { border = "rounded" },
  checker = {
    enabled = true,   -- auto-check for plugin updates
    notify  = false,
  },
})
