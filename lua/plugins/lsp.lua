return {
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
          "ols",
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

      vim.diagnostic.config({
        virtual_text     = true,
        signs            = true,
        underline        = true,
        update_in_insert = false,
        float            = { border = "rounded" },
      })
    end,
  },
}
