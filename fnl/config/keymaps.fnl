;; Keymaps - Helix-inspired bindings
(local keymap vim.keymap.set)
(local opts {:noremap true :silent true})

;; Disable space in normal/visual mode (it's our leader)
(keymap [:n :v] :<Space> :<Nop> {:silent true})

;; Better window navigation
(keymap :n :<C-h> :<C-w>h opts)
(keymap :n :<C-j> :<C-w>j opts)
(keymap :n :<C-k> :<C-w>k opts)
(keymap :n :<C-l> :<C-w>l opts)

;; Resize windows
(keymap :n :<C-Up> ":resize +2<CR>" opts)
(keymap :n :<C-Down> ":resize -2<CR>" opts)
(keymap :n :<C-Left> ":vertical resize -2<CR>" opts)
(keymap :n :<C-Right> ":vertical resize +2<CR>" opts)

;; Buffer navigation
(keymap :n :<S-l> ":bnext<CR>" opts)
(keymap :n :<S-h> ":bprevious<CR>" opts)

;; Move lines (Helix Alt-up/down style)
(keymap :n :<M-k> ":m .-2<CR>==" opts)
(keymap :n :<M-j> ":m .+1<CR>==" opts)
(keymap :v :<M-k> ":m '<-2<CR>gv=gv" opts)
(keymap :v :<M-j> ":m '>+1<CR>gv=gv" opts)
(keymap :n :<M-Up> ":m .-2<CR>==" opts)
(keymap :n :<M-Down> ":m .+1<CR>==" opts)
(keymap :v :<M-Up> ":m '<-2<CR>gv=gv" opts)
(keymap :v :<M-Down> ":m '>+1<CR>gv=gv" opts)

;; Stay in indent mode
(keymap :v :<  :<gv opts)
(keymap :v :>  :>gv opts)

;; Better paste (don't yank replaced text)
(keymap :v :p "\"_dP" opts)

;; Clear search highlighting
(keymap :n :<Esc> ":noh<CR>" opts)

;; Quick escape from insert mode (alternative to jk/jj)
(keymap :i :jk :<Esc> opts)
(keymap :i :jj :<Esc> opts)

;; Quick save/quit (Helix-style)
(keymap :n :<leader>w ":w<CR>" {:noremap true :silent true :desc "Save file"})
(keymap :n :<leader>q ":q<CR>" {:noremap true :silent true :desc "Quit"})
(keymap :n :<leader>Q ":qa!<CR>" {:noremap true :silent true :desc "Quit all (force)"})

;; File explorer (will be set by neo-tree/oil)
(keymap :n :<leader>e ":Neotree toggle<CR>" {:noremap true :silent true :desc "Toggle file explorer"})

;; LSP keymaps (set in lsp.fnl when LSP attaches)

;; Terminal mappings
(keymap :t :<Esc> "<C-\\><C-n>" opts)
(keymap :t :<C-h> "<C-\\><C-n><C-w>h" opts)
(keymap :t :<C-j> "<C-\\><C-n><C-w>j" opts)
(keymap :t :<C-k> "<C-\\><C-n><C-w>k" opts)
(keymap :t :<C-l> "<C-\\><C-n><C-w>l" opts)
