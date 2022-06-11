local map = vim.api.nvim_buf_set_keymap
local noremap = { noremap = true }

vim.o.softtabstop = 8
vim.o.shiftwidth = 8
vim.o.tabstop = 8
vim.o.textwidth = 80
vim.o.expandtab = false

-- run the project
map(0, "n", "<leader>r", "<cmd>!hare run %<cr>", noremap)

-- build the project
map(0, "n", "<leader>b", "<cmd>make<cr>", noremap)

-- map(0, "n", "K", "", {
-- 	noremap = true,
-- 	callback = function()
-- 		local oldiskeyword = vim.opt_local.iskeyword
-- 		vim.opt_local.iskeyword:append(":")
-- 		local symbol = vim.fn.expand('<cword>')
-- 		vim.opt_local.iskeyword = oldiskeyword
--
-- 		vim.lsp.util.open_floating_preview({"hello world"})
-- 	end
-- })
