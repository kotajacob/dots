local map = vim.api.nvim_buf_set_keymap
local noremap = { noremap = true }

-- run the project
map(0, "n", "<leader>r", "<cmd>!hare run %<cr>", noremap)

-- build the project
map(0, "n", "<leader>b", "<cmd>make<cr>", noremap)
