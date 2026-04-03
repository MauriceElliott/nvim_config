local map = vim.keymap.set

-- Leader
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Move lines (Alt+up/down like Helix)
map("n", "<A-Up>",   "<cmd>move .-2<CR>==")
map("n", "<A-Down>", "<cmd>move .+1<CR>==")
map("v", "<A-Up>",   ":move '<-2<CR>gv=gv")
map("v", "<A-Down>", ":move '>+1<CR>gv=gv")

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>")
map("n", "<S-l>", "<cmd>bnext<CR>")
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Neo-tree toggle
map("n", "<leader>t", "<cmd>Neotree toggle<CR>", { desc = "Toggle file tree" })
