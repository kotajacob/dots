local map = vim.api.nvim_buf_set_keymap
local noremap = { noremap = true }

-- Run the project
map(0, "n", "<leader>r", "<cmd>GoRun<cr>", noremap)

-- Run the current file
map(0, "n", "<leader>R", "<cmd>GoRun %<cr>", noremap)

-- Build the project
map(0, "n", "<leader>b", "<cmd>GoBuild<cr>", noremap)

-- Test the project
map(0, "n", "<leader>tt", "<cmd>GoTest<cr>", noremap)

-- Identifier resolution
map(0, "n", "<leader>i", "<Plug>(go-info)", noremap)

-- Test the function under your cursor
map(0, "n", "<leader>tf", "<cmd>GoTestFunc<cr>", noremap)

-- Run MetaLinter on the current project
map(0, "n", "<leader>tm", "<cmd>GoMetaLinter<cr>", noremap)

-- Show go coverage inline WOAH
map(0, "n", "<leader>tc", "<cmd>GoCoverageToggle<cr>", noremap)

-- Swap to test or back
map(0, "n", "<S-Tab>", "<cmd>GoAlternate!<cr>", noremap)
