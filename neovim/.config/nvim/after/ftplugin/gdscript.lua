vim.o.formatoptions = 'jcrql'
local map = vim.api.nvim_buf_set_keymap
local noremap = { noremap = true }

-- Runs the project
map(0, "n", "<leader>r", "<cmd>GodotRun<cr>", noremap)

-- Runs the current file
map(0, "n", "<leader>R", "<cmd>GodotRunFZF<cr>", noremap)
