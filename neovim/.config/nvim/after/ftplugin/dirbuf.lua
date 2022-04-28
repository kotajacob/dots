local map = vim.api.nvim_buf_set_keymap
local noremap = { noremap = true }

map(0, "n", "h", "<Plug>(dirbuf_up)", noremap)
map(0, "n", "l", "<Plug>(dirbuf_enter)", noremap)
