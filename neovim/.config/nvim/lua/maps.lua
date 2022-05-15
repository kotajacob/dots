local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local snoremap = { noremap = true, silent = true }

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
map('n', '<space>n', ':nohl<CR>', snoremap)

-- Toggle hidden characters
map('n', '<space>sh', ':set list!<cr>', snoremap)

-- Toggle spell checking
map('n', '<space>ss', ':set spell!<cr>', snoremap)

-- Toggle line wrapping
map('n', '<space>sw', ':set wrap!<cr>', snoremap)

-- Toggle virtual edit (move around freely in the window)
map('n', '<space>sv', '', {
	noremap = true,
	silent = true,
	callback = function()
		if (vim.o.virtualedit == '') then
			vim.o.virtualedit = 'all'
		else
			vim.o.virtualedit = ''
		end
	end,
})

-- Toggle number
map('n', '<space>sn', '', {
	noremap = true,
	silent = true,
	callback = function()
		vim.o.relativenumber = not vim.o.relativenumber
		vim.o.number = not vim.o.number
	end,
})

-- Repeat macros with , because @@ is too long for me lol
map('n', ',', '@@', noremap)

-- Close other windows
map('n', '<space>o', ':only<CR>', snoremap)

-- Hop around
map('n', '<space><space>', "", {
	noremap = true,
	callback = function()
		require 'hop'.hint_char2()
	end
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

-- Use dial.nvim (speed-dating clone) instead of defaults
map("n", "<C-a>", require("dial.map").inc_normal(), snoremap)
map("n", "<C-x>", require("dial.map").dec_normal(), snoremap)
map("v", "<C-a>", require("dial.map").inc_visual(), snoremap)
map("v", "<C-x>", require("dial.map").dec_visual(), snoremap)
map("v", "g<C-a>", require("dial.map").inc_gvisual(), snoremap)
map("v", "g<C-x>", require("dial.map").dec_gvisual(), snoremap)

-- Align text (EasyAlign)
map("v", "ga", "<Plug>(EasyAlign)", snoremap)
map("n", "ga", "<Plug>(EasyAlign)", snoremap)

-- Show highlight group with F12
map("n", "<F12>", ":TSHighlightCapturesUnderCursor<CR>", snoremap)

-- Map %% to return my current working directory
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>", snoremap)

-- Open undotree
map("n", "<space>su", ":UndotreeToggle<CR>", snoremap)

-- Schlepp
map("v", "<up>", "<Plug>SchleppUp", snoremap)
map("v", "<down>", "<Plug>SchleppDown", snoremap)
map("v", "<left>", "<Plug>SchleppLeft", snoremap)
map("v", "<right>", "<Plug>SchleppRight", snoremap)

-- Date command ... but in lua?
map("n", "<space>dd", [[:exec 'normal a'.substitute(system("date -Iseconds"),"[\n]*$","","")<CR>]], snoremap)
map("n", "<space>ds", [[:exec 'normal a'.substitute(system("date +%Y-%m-%d"),"[\n]*$","","")<CR>]], snoremap)

-- Move between splits without C-W prefix
map('n', '<C-J>', '<C-W><C-J>', {})
map('n', '<C-K>', '<C-W><C-K>', {})
map('n', '<C-L>', '<C-W><C-L>', {})
map('n', '<C-H>', '<C-W><C-H>', {})

