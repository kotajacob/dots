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
require('mini.ai').setup()    -- a/i text object improvements
require('mini.align').setup() -- align with gaipi<space> or gaip-
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
require('mini.comment').setup()      -- comment with gcc
require('mini.completion').setup()   -- completion and signature help
require('mini.diff').setup()         -- show and manipulate git diffs
require('mini.indentscope').setup()  -- indent text object with ii
require('mini.move').setup()         -- move code with alt+hjkl
require('mini.splitjoin').setup()    -- split and join long lines
require('mini.surround').setup()     -- sa (add), sd (delete), sr (replace)
require('mini.trailspace').setup()   -- highlight trailing spaces
vim.g.miniindentscope_disable = true -- disable animation

require('mini.pairs').setup({
	mappings = {
		['`'] = false,
	},
})

require('mini.operators').setup({ -- exchange, evaluate, repeat, multiply
	exchange = {
		prefix = 'cx'
	},
	replace = {
		prefix = 'cr'
	}
})

local add = MiniDeps.add

-- Lua plugins
add('neovim/nvim-lspconfig')
add({
	source = 'nvim-treesitter/nvim-treesitter',
	-- Use 'master' while monitoring updates in 'main'
	checkout = 'master',
	monitor = 'main',
	-- Perform action after every checkout
	hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
local function make_fzf_native(params)
	vim.cmd("lcd " .. params.path)
	vim.cmd("!make -s")
	vim.cmd("lcd -")
end
add({
	source = 'nvim-telescope/telescope.nvim',
	depends = {
		'nvim-lua/plenary.nvim',
		{
			source = "nvim-telescope/telescope-fzf-native.nvim",
			hooks = {
				post_install = make_fzf_native,
				post_checkout = make_fzf_native,
			},
		}
	},
})
add('stevearc/dressing.nvim')
add('elihunter173/dirbuf.nvim')
add('rmagatti/gx-extended.nvim')
add('L3MON4D3/LuaSnip')
add('rafamadriz/friendly-snippets')
add('mhartington/formatter.nvim')

-- Vim script plugins
add('tpope/vim-fugitive')
add('mattn/emmet-vim')
add('lervag/file-line')
add('fatih/vim-go')
add('lervag/wiki.vim')
add('lervag/wiki-ft.vim')
add('https://git.sr.ht/~jcc/vim-sway-nav')

require('plugin/lsp')
require('plugin/formatter')
require('plugin/treesitter')
require('plugin/telescope')
require('plugin/dirbuf')
require('plugin/luasnip')
