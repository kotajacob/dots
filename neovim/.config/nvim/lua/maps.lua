local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local snoremap = { noremap = true, silent = true }

map("n", "<space><space>", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").find_files()
	end,
})

map("n", "<space>.", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").resume()
	end,
})

map("n", "<space>/", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").live_grep()
	end,
})

map("n", "<space>?", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").live_grep({ cwd = vim.fn.expand('%:p:h') })
	end,
})

map("n", "<space>m", "", {
	noremap = true,
	callback = function ()
		require("telescope.builtin").marks()
	end
})

map("n", "<space>b", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").buffers({
			show_all_buffers = false,
			ignore_current_buffer = true,
			sort_mru = true,
		})
	end,
})

map("n", "<space>O", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").oldfiles({cwd_only=true})
	end,
})

map("n", "<space>H", "", {
	noremap = true,
	callback = function()
		require("telescope.builtin").command_history()
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

-- Open trouble (error list)
map("n", "<space>el", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)

-- close a buffer
map('n', '<Del>', ':close<CR>', noremap)

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
map('n', '<space>cc', ':nohl<CR>', snoremap)

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

-- Map %% to return my current working directory
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>", snoremap)

-- Move between splits without C-W prefix
map('n', '<C-j>', '<C-W><C-j>', snoremap)
map('n', '<C-k>', '<C-W><C-k>', snoremap)
map('n', '<C-l>', '<C-W><C-l>', snoremap)
map('n', '<C-h>', '<C-W><C-h>', snoremap)

-- Remove trailing whitespace
map("n", "<space>wr", "", {
	noremap = true,
	callback = function()
		MiniTrailspace.trim()
	end,
})

-- Show git panel
map("n", "<space>gg", ":G<CR>", snoremap)

-- Show diff preview
map("n", "ghp", "", {
	noremap = true,
	callback = function()
		MiniDiff.toggle_overlay(0)
	end,
})

-- Tab completion (instead of control-n)
vim.keymap.set(
	'i',
	'<Tab>',
	[[pumvisible() ? "\<C-n>" : "\<Tab>"]],
	{ expr = true }
)
vim.keymap.set(
	'i',
	'<S-Tab>',
	[[pumvisible() ? "\<C-p>" : "\<S-Tab>"]],
	{ expr = true }
)
