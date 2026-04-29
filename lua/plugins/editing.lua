return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,      desc = "Remote flash" },
    },
  },
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    opts = {},
    keys = {
      { "<S-c>",          "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "x" }, desc = "Add cursor below" },
      { "<S-Up>",         "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "x" }, desc = "Add cursor above" },
      { "<C-LeftMouse>",  "<Cmd>MultipleCursorsMouseAddDelete<CR>",   mode = { "n", "i" }, desc = "Add/remove cursor" },
      { "<Leader>a",      "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" }, desc = "Add cursors to word" },
      { "<Leader>A",      "<Cmd>MultipleCursorsLock<CR>",             mode = { "n", "x" }, desc = "Lock cursors" },
    },
  },
}
