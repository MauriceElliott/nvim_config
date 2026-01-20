;; Neovim options (Helix-inspired)
(local opt vim.opt)

;; Leader key
(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")

;; Basic settings
(set opt.number true)
(set opt.relativenumber true)
(set opt.cursorline true)
(set opt.scrolloff 8)
(set opt.signcolumn "yes")
(set opt.colorcolumn "100")

;; Indentation (matching Helix defaults)
(set opt.tabstop 4)
(set opt.softtabstop 4)
(set opt.shiftwidth 4)
(set opt.expandtab true)
(set opt.smartindent true)

;; Search
(set opt.hlsearch false)
(set opt.incsearch true)
(set opt.ignorecase true)
(set opt.smartcase true)

;; UI
(set opt.termguicolors true)
(set opt.wrap false)
(set opt.showmode false)
(set opt.completeopt ["menu" "menuone" "noselect"])
(set opt.pumheight 10)

;; Mouse & clipboard
(set opt.mouse "a")
(set opt.clipboard "unnamedplus")

;; Performance
(set opt.updatetime 250)
(set opt.timeoutlen 300)
(set opt.undofile true)
(set opt.swapfile false)
(set opt.backup false)

;; Splits
(set opt.splitright true)
(set opt.splitbelow true)

;; Wildmenu
(set opt.wildmode ["longest" "list"])
(set opt.wildignore "*.pyc,*_build/*,*/coverage/*,*/node_modules/*,*/.git/*")
