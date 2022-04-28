local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }

-- Move between splits without C-W prefix
map('n', '<C-J>', '<C-W><C-J>', noremap)
map('n', '<C-K>', '<C-W><C-K>', noremap)
map('n', '<C-L>', '<C-W><C-L>', noremap)
map('n', '<C-H>', '<C-W><C-H>', noremap)

-- Visual shifting (does not exit Visual mode)
map('v', '<', '<gv', noremap)
map('v', '>', '>gv', noremap)

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
map('n', 'n', 'nzzzv', noremap)
map('n', 'N', 'Nzzzv', noremap)

-- Remap j and k to move by display with wrapped lines, but also move the
-- correct number of lines when preceded with a count. Counts greater than 5
-- will be added to the movement history to make Control-O and Control-I work.
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Disable search highlighting
map('n', '<space>n', ':nohl<CR>', noremap)

-- Toggle hidden characters
map('n', '<space>sh', ':set list!<cr>', noremap)

-- Close other windows
map('n', '<space>o', ':only<CR>', noremap)


-- Hop binds
map('n', '<space><space>', "", {
	callback = function()
		require'hop'.hint_char2()
	end,
	noremap = true
})

-- Telescope binds
map("n", "<space>f", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").find_files()
	end,
})
map("n", "<space>/", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").live_grep()
	end,
})
map("n", "<space>F", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").git_files()
	end,
})
map("n", "<space>b", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").buffers()
	end,
})
map("n", "z=", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").spell_suggest()
	end,
})
map("n", "<space>h", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").help_tags()
	end,
})
map("n", "<space>k", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").keymaps()
	end,
})
map("n", "gr", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").lsp_references()
	end,
})
map("n", "<space>ca", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").lsp_code_actions()
	end,
})

-- Trouble error list
map("n", "<space>el", ":TroubleToggle<CR>", noremap)

-- Fugitive 3-way diff
map("n", "<leader>gd", ":Gvdiff<CR>", noremap)
map("n", "gh", ":diffget //2<CR>", noremap)
map("n", "gl", ":diffget //3<CR>", noremap)

-- Use dial.nvim (speed-dating clone) instead of defaults
map("n", "<C-a>", require("dial.map").inc_normal(), noremap)
map("n", "<C-x>", require("dial.map").dec_normal(), noremap)
map("v", "<C-a>", require("dial.map").inc_visual(), noremap)
map("v", "<C-x>", require("dial.map").dec_visual(), noremap)
map("v", "g<C-a>", require("dial.map").inc_gvisual(), noremap)
map("v", "g<C-x>", require("dial.map").dec_gvisual(), noremap)

-- Align text (EasyAlign)
map("v", "ga", "<Plug>(EasyAlign)", noremap)
map("n", "ga", "<Plug>(EasyAlign)", noremap)

-- Show highlight group with F12
map("n", "<F12>", ":TSHighlightCapturesUnderCursor<CR>", noremap)

-- Map %% to return my current working directory
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>", noremap)

-- Open undotree
map("n", "<space>su", ":UndotreeToggle<CR>", noremap)

-- Schlepp
map("v", "<up>", "<Plug>SchleppUp", noremap)
map("v", "<down>", "<Plug>SchleppDown", noremap)
map("v", "<left>", "<Plug>SchleppLeft", noremap)
map("v", "<right>", "<Plug>SchleppRight", noremap)

-- Date command ... but in lua?
map("n", "<space>dd", "", {
	noremap = true,
	callback = function()
		vim.api.nvim_put({os.date("%Y-%m-%dT%H:%M:%S")}, "l", false, true)
	end,
})

map("n", "<space>ds", "", {
	noremap = true,
	callback = function()
		vim.api.nvim_put({os.date("%Y-%m-%d")}, "l", false, true)
	end,
})
