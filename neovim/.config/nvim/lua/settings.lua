local o = vim.o
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

-- Make neovim pretty
o.number = true
o.cursorline = true
o.colorcolumn = '80'
o.showmode = false
o.cmdheight = 2
o.scrolloff = 4
o.sidescrolloff = 5
o.termguicolors = true
o.background = 'light'

-- Use dirbuf instead of netrw
g.loaded_netrwPlugin = 1
g.loaded_netrw = 1

-- Use matchup instead of matchit
g.loaded_matchit = 1

-- Use par for formatting text blocks
o.formatprg = 'par -w80'

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
o.whichwrap = 'b,s,<,>,[,]'

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
o.signcolumn = 'yes' -- Always use signcolumn
o.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic' -- Enable nvim diffing
o.updatetime = 100 -- Faster responce time
o.confirm = true -- Show a dialog to confirm changes instead of failure
o.mouse = 'a' -- Enable use of the mouse for all modes
o.foldlevelstart = 99 -- Open all folds by default
o.breakindent = true -- Multiline indenting

-- Disable line ending diagnotic messages
vim.diagnostic.config({
	virtual_text = false,
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

-- memex
autocmd('BufRead,BufNewFile', {
	pattern = '*/memex/*.md',
	command = 'set filetype=wiki',
})

vim.g.wiki_root = "~/docs/memex"
vim.g.wiki_filetypes = { 'md', 'wiki' }
