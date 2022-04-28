local map = vim.api.nvim_buf_set_keymap
local noremap = { noremap = true }

-- Hot Reload
map(0, "n", "<leader>r", "<cmd>FlutterReload<cr>", noremap)

-- Hot Restart
map(0, "n", "<leader>R", "<cmd>FlutterRestart<cr>", noremap)

-- Open log vertically.
map(0, "n", "<leader>v", "<cmd>FlutterVSplit<cr>", noremap)
