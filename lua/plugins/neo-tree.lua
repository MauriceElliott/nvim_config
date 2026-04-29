return {
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
}
