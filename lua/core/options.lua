local opt = vim.opt

-- Line numbers
opt.number         = true
opt.relativenumber = true

-- Indentation
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.expandtab      = true
opt.smartindent    = true

-- Appearance
opt.termguicolors  = true
opt.cursorline     = true
opt.signcolumn     = "yes"
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.wrap           = true
opt.linebreak      = true   -- soft-wrap at word boundaries

-- Search
opt.ignorecase     = true
opt.smartcase      = true
opt.hlsearch       = true
opt.incsearch      = true

-- Splits
opt.splitbelow     = true
opt.splitright     = true

-- Files
opt.hidden         = true   -- allow unsaved buffers in background
opt.autoread       = true
opt.swapfile       = false
opt.backup         = false
opt.undofile       = true
opt.undodir        = vim.fn.stdpath("data") .. "/undo"

-- Completion
opt.completeopt    = { "menu", "menuone", "noselect" }

-- Misc
opt.mouse          = "a"
opt.clipboard      = "unnamedplus"
opt.updatetime     = 250
opt.timeoutlen     = 300
opt.showmode       = false  -- mode shown by statusline instead
