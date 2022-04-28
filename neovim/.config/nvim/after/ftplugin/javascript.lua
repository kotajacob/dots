local map = vim.api.nvim_buf_set_keymap
local noremap = { noremap = true }

-- Runs the current file
map(0, "n", "<leader>r", "<cmd>!node %<cr>", noremap)

-- Runs the project
map(0, "n", "<leader>R", "<cmd>r! node <cr>", noremap)
