-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Neotree
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', {})
vim.keymap.set('n', '<C-h>', ':Neotree focus<CR>', {})

vim.keymap.set('n', '<leader>q', ':q!<CR>', {})
vim.keymap.set('n', '<leader>w', ':w<CR>', {})
vim.keymap.set('n', '<leader>x', ':x<CR>', {})
