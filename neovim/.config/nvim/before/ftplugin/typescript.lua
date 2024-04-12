vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.formatoptions = 'jcrql'
local map = vim.api.nvim_buf_set_keymap
local noremap = { noremap = true }

-- Runs the current file
map(0, "n", "<leader>r", "<cmd>!node %<cr>", noremap)

-- Runs the project
map(0, "n", "<leader>R", "<cmd>r! node <cr>", noremap)