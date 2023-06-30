local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- many lil things
	"echasnovski/mini.nvim",

	-- lsp
	'neovim/nvim-lspconfig',
	'crispgm/nvim-go',
	{ "stevearc/dressing.nvim", event = "VeryLazy" },

	-- icons for stuff
	'nvim-tree/nvim-web-devicons',

	-- dirbuf as filemanager
	'elihunter173/dirbuf.nvim',

	-- treesitter
	'nvim-treesitter/nvim-treesitter',

	-- git gutter and other such things
	'lewis6991/gitsigns.nvim',

	-- "exchange" operator to swap selections
	'tommcdo/vim-exchange',

	-- fuzzy searcher
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		}
	},
})

local o = vim.o
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

-- Make neovim pretty
o.number = true
o.showmode = false
o.scrolloff = 4
o.sidescrolloff = 5

-- Use dirbuf instead of netrw
g.loaded_netrwPlugin = 1
g.loaded_netrw = 1

-- Use telescope instead of fzf
g.loaded_fzf = 1

-- Project-local marks and oldfiles!
o.viminfofile=vim.api.nvim_eval([[findfile('.viminfo','.;')]])
-- use :Pnew to 'init' a new project
-- or touch .viminfo :D

-- Enable persistent undo
o.undofile = true

-- Don't litter swp files everywhere
o.writebackup = false

-- Traverse lines with arrow keys
vim.o.whichwrap = 'b,s,<,>,[,]'

-- Indentation settings for using hard tabs for indent
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4
o.expandtab = false

-- Use case insensitive search, except when using capital letters
o.ignorecase = true
o.smartcase = true

-- Hidden character config
o.listchars = 'tab:» ,space:·,nbsp:␣,eol:¬'

-- Misc
o.timeout = false -- Time out on keycodes, but not mappings
o.linebreak = true -- Set word wrapping on
o.autowrite = true -- Automatically write when :make or :GoBuild are called
o.clipboard = 'unnamed' -- Set the default register to * so I can have a shared OS clipboard
o.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic' -- Enable nvim diffing
o.updatetime = 100 -- Faster responce time
o.confirm = true -- Show a dialog to confirm changes instead of failure
o.mouse = 'a' -- Enable use of the mouse for all modes
o.foldlevelstart = 99 -- Open all folds by default
o.breakindent = true -- Multiline indenting

-- Disable line ending diagnotic messages
vim.diagnostic.config({
	signs = false,
})

-- Restore cursor position
autocmd('BufReadPost', {
	pattern = '*',
	callback = function()
		vim.fn.setpos('.', vim.fn.getpos("'\""))
	end,
})

-- Highlight on yank
autocmd('TextYankPost', {
	pattern = '*',
	callback = function()
		vim.highlight.on_yank { higroup = 'IncSearch', timeout = 350 }
	end,
})

-- Setup mini plugins
require('mini.ai').setup() -- a/i text object improvements
require('mini.align').setup() -- align with gaipi<space> or gaip-
require('mini.bracketed').setup({
	buffer		 = { suffix = 'b', options = {} },
	comment		 = { suffix = 'x', options = {} },
	conflict	 = { suffix = 'c', options = {} },
	diagnostic = { suffix = 'd', options = {} },
	file			 = { suffix = 'f', options = {} },
	indent		 = { suffix = 'i', options = {} },
	jump			 = { suffix = 'j', options = {} },
	location	 = { suffix = 'l', options = {} },
	oldfile		 = { suffix = 'o', options = {} },
	quickfix	 = { suffix = 'q', options = {} },
	treesitter = { suffix = 't', options = {} },
	undo			 = { suffix = 'u', options = {} },
	window		 = { suffix = 'w', options = {} },
	yank			 = { suffix = 'y', options = {} },
})
require('mini.comment').setup() -- comment with gcc
require('mini.indentscope').setup() -- indent text object with ii
require('mini.splitjoin').setup() -- gS to split
require('mini.surround').setup() -- sa (add), sd (delete), sr (replace)
require('mini.statusline').setup() -- the line at the bottom
require('mini.trailspace').setup() -- highlight trailing spaces
require('mini.move').setup() -- move code with alt+hjkl
g.miniindentscope_disable = true -- disable animation

require('dirbuf').setup {
	show_hidden = false,
	sort_order = 'directories_first',
	write_cmd = 'DirbufSync',
}

require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,
	},
}

require('telescope').setup {
	defaults = {
		path_display = { 'truncate' },
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "bottom",
			preview_cutoff = 1, -- Show preview (unless previewer = false)

			width = function(_, max_columns, _)
				return math.min(max_columns, 80)
			end,
		},
		border = true,
	},
	pickers = {
		spell_suggest = {
			theme = "cursor",
		},
		buffers = {
			mappings = {
				i = {
					["<Del>"] = require('telescope.actions').delete_buffer,
				},
			},
		}
	},
}
require('telescope').load_extension('fzf')

require('gitsigns').setup {
	signs = {
		add					 = {
			hl = 'GitSignsAdd',
			text = '│',
			numhl = 'GitSignsAddNr',
			linehl = 'GitSignsAddLn',
		},
		change			 = {
			hl = 'GitSignsChange',
			text = '│',
			numhl = 'GitSignsChangeNr',
			linehl = 'GitSignsChangeLn',
		},
		delete			 = {
			hl = 'GitSignsDelete',
			text = '│',
			numhl = 'GitSignsDeleteNr',
			linehl = 'GitSignsDeleteLn',
		},
		topdelete		 = {
			hl = 'GitSignsDelete',
			text = '│',
			numhl = 'GitSignsDeleteNr',
			linehl = 'GitSignsDeleteLn',
		},
		changedelete = {
			hl = 'GitSignsChange',
			text = '│',
			numhl = 'GitSignsChangeNr',
			linehl = 'GitSignsChangeLn',
		},
	},
	signcolumn = false,
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', ']c', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		map('n', '[c', function()
			if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		-- Actions
		map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
		map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
		map('n', '<leader>hS', gs.stage_buffer)
		map('n', '<leader>hu', gs.undo_stage_hunk)
		map('n', '<leader>hR', gs.reset_buffer)
		map('n', '<leader>hp', gs.preview_hunk)
		map('n', '<leader>hb', function() gs.blame_line { full = true } end)
		map('n', '<leader>tb', gs.toggle_current_line_blame)
		map('n', '<leader>hd', gs.diffthis)
		map('n', '<leader>hD', function() gs.diffthis('~') end)
		map('n', '<leader>td', gs.toggle_deleted)

		-- Text object
		map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end
}

-- LSP
require('dressing').setup({
	input = {
		insert_only = false,
		win_options = {
			winblend = 0,
		},
	},
	select = {
		telescope = require('telescope.themes').get_cursor({})
	}
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>ee', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require('go').setup({
	auto_lint = false,
	maintain_cursor_pos = true,
})

local nvim_lsp = require("lspconfig")

nvim_lsp.gopls.setup {
	on_attach = on_attach,
}

nvim_lsp.lua_ls.setup {
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local snoremap = { noremap = true, silent = true }

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

-- Toggle signs
map('n', '<space>gs', ':Gitsigns toggle_signs<CR>', snoremap)

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


-- Telescope binds
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

-- Map %% to return my current working directory
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>", snoremap)

-- Date command ... but in lua?
map("n", "<space>dd", [[:exec 'normal a'.substitute(system("date -Iseconds"),"[\n]*$","","")<CR>]], snoremap)
map("n", "<space>ds", [[:exec 'normal a'.substitute(system("date +%Y-%m-%d"),"[\n]*$","","")<CR>]], snoremap)

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
