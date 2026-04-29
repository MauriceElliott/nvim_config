return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk      = require("which-key")
      local builtin = require("telescope.builtin")

      wk.setup({
        preset = "modern",
        delay  = 300,
      })

      wk.add({
        { "<leader>f", function()
            builtin.find_files({ hidden = true })
          end,                                              desc = "Find files" },

        { "<leader>.", function()
            local dir = vim.fn.expand("%:p:h")
            builtin.find_files({ cwd = dir, hidden = true })
          end,                                              desc = "Find files (here)" },

        { "<leader>e", "<cmd>Telescope file_browser<CR>",  desc = "Browse folders" },
        { "<leader>/", builtin.live_grep,                  desc = "Search in project" },
        { "<leader>b", builtin.buffers,                    desc = "Buffers" },
        { "<leader>t", "<cmd>Neotree toggle<CR>",          desc = "Toggle file tree" },
        { "<leader>x", "<cmd>bdelete<CR>",                 desc = "Close buffer" },

        -- LSP group
        { "<leader>l",  group = "LSP" },
        { "<leader>ld", vim.lsp.buf.definition,            desc = "Go to definition" },
        { "<leader>lD", vim.lsp.buf.declaration,           desc = "Go to declaration" },
        { "<leader>lr", vim.lsp.buf.references,            desc = "References" },
        { "<leader>lR", vim.lsp.buf.rename,                desc = "Rename symbol" },
        { "<leader>la", vim.lsp.buf.code_action,           desc = "Code action" },
        { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
        { "<leader>lk", vim.lsp.buf.hover,                 desc = "Hover docs" },
        { "<leader>li", vim.lsp.buf.implementation,        desc = "Implementation" },

        -- Git hunks group
        { "<leader>h",  group = "Git hunks" },
        { "<leader>hs", function() require("gitsigns").stage_hunk() end,                desc = "Stage hunk" },
        { "<leader>hr", function() require("gitsigns").reset_hunk() end,                desc = "Reset hunk" },
        { "<leader>hp", function() require("gitsigns").preview_hunk() end,              desc = "Preview hunk" },
        { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line" },

        -- Diagnostics group
        { "<leader>d",  group = "Diagnostics" },
        { "<leader>dd", vim.diagnostic.open_float,         desc = "Show diagnostic" },
        { "<leader>dl", builtin.diagnostics,               desc = "List diagnostics" },
        { "<leader>dn", vim.diagnostic.goto_next,          desc = "Next diagnostic" },
        { "<leader>dp", vim.diagnostic.goto_prev,          desc = "Prev diagnostic" },
      })
    end,
  },
}
