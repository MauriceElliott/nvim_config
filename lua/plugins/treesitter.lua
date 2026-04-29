return {
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
        "powershell", "odin",
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
}
