--This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
	  use 'wbthomason/packer.nvim'
	  use {
 		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
  	  	requires = { {'nvim-lua/plenary.nvim'} }
	  }
	  use({
		'scottmckendry/cyberdream.nvim',
		  as = 'cyberdream',
		  config = function()
		 	vim.cmd('colorscheme cyberdream')
		  end
	  })
    use {
    'johnfrankmorgan/whitespace.nvim',
    config = function ()
        require('whitespace-nvim').setup({
            -- configuration options and their defaults

            -- `highlight` configures which highlight is used to display
            -- trailing whitespace
            highlight = 'DiffDelete',

            -- `ignored_filetypes` configures which filetypes to ignore when
            -- displaying trailing whitespace
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'dashboard' },

            -- `ignore_terminal` configures whether to ignore terminal buffers
            ignore_terminal = true,

            -- `return_cursor` configures if cursor should return to previous
            -- position after trimming whitespace
            return_cursor = true,
        })

        -- remove trailing whitespace with a keybinding
        vim.keymap.set('n', '<Leader>tw', require('whitespace-nvim').trim)
    end
    }
    use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
end)
