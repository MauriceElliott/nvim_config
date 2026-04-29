return {
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
          local gs  = package.loaded.gitsigns
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
  },
}
