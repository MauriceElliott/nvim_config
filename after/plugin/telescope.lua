local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sd', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sa', builtin.git_files, { desc = 'Telescope git only files' })
vim.keymap.set('n', '<leader>sq', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
