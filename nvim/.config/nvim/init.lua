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

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })
require('mini.ai').setup()            -- a/i text object improvements
require('mini.align').setup()         -- align with gaipi<space> or gaip-
require('mini.bracketed').setup({
	buffer     = { suffix = 'b', options = {} },
	comment    = { suffix = 'x', options = {} },
	conflict   = { suffix = 'c', options = {} },
	diagnostic = { suffix = 'd', options = {} },
	file       = { suffix = 'f', options = {} },
	indent     = { suffix = 'i', options = {} },
	jump       = { suffix = 'j', options = {} },
	location   = { suffix = 'l', options = {} },
	oldfile    = { suffix = 'o', options = {} },
	quickfix   = { suffix = 'q', options = {} },
	treesitter = { suffix = 't', options = {} },
	undo       = { suffix = 'u', options = {} },
	window     = { suffix = 'w', options = {} },
	yank       = { suffix = 'y', options = {} },
})
require('mini.comment').setup()       -- comment with gcc
require('mini.completion').setup()    -- completion and signature help
require('mini.diff').setup()          -- Show and manipulate git diffs
require('mini.indentscope').setup()   -- indent text object with ii
require('mini.move').setup()          -- move code with alt+hjkl
require('mini.splitjoin').setup()     -- split and join long lines
require('mini.surround').setup()      -- sa (add), sd (delete), sr (replace)
require('mini.trailspace').setup()    -- highlight trailing spaces
vim.g.miniindentscope_disable = true  -- disable animation

local add = MiniDeps.add

add('nvim-tree/nvim-web-devicons')
require('nvim-web-devicons').setup()

add({
	source = 'nvim-treesitter/nvim-treesitter',
	-- Use 'master' while monitoring updates in 'main'
	checkout = 'master',
	monitor = 'main',
	-- Perform action after every checkout
	hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
require('nvim-treesitter.configs').setup({
	ensure_installed = {
		"c",
		"css",
		"gdscript",
		"glsl",
		"go",
		"hare",
		"java",
		"javascript",
		"lua",
		"query",
		"rust",
		"typescript",
		"vimdoc",
		"zig",
	},
	highlight = { enable = true },
})
