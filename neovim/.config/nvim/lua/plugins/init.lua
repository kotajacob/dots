require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

	-- "Libraries"
	use 'nvim-lua/plenary.nvim'
	use 'tpope/vim-repeat'

	-- Startup speed improvement (must call require before others plugins!)
	use {
		'lewis6991/impatient.nvim',
		config = function() require('impatient') end
	}

	-- Colorscheme
	use 'RRethy/nvim-base16'
	use {
		'nvim-lualine/lualine.nvim',
		requires = "kyazdani42/nvim-web-devicons"
	}

	-- Advanced syntax highlighting and more...
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use {
		'lewis6991/spellsitter.nvim',
		config = function() require('spellsitter').setup() end
	}
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'nvim-treesitter/playground' -- Show highlight group w/ f12

	-- LSP
 	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp' -- TODO: swap for nvim-compleet eventually...
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	-- Trouble.nvim to show better diagnostics
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	}

	-- Snippet
	use 'hrsh7th/cmp-vsnip' -- TODO: swap with luasnip
	use 'hrsh7th/vim-vsnip'

	-- Language support
	use 'jose-elias-alvarez/null-ls.nvim'
	use 'jose-elias-alvarez/nvim-lsp-ts-utils'
	use 'mfussenegger/nvim-jdtls'
	use {
		'fatih/vim-go',
		run = ':GoUpdateBinaries',
		ft = {'go', 'gomod', 'gowork'}
	}

	-- Hop around the page quickly
	use {
		'phaazon/hop.nvim', -- TODO: theme with base16
		branch = 'v1', -- optional but strongly recommended
		config = function()
			require'hop'.setup()
		end
	}

	-- Fuzzy searcher
	use 'nvim-telescope/telescope.nvim'
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	-- dirbuf as filemanager
	use "elihunter173/dirbuf.nvim"

	-- Toggleterm to quickly open a terminal
	use 'akinsho/toggleterm.nvim'

	-- Wiki
	use { 'lervag/wiki.vim', ft = 'wiki' }
	use { 'lervag/wiki-ft.vim', ft = 'wiki' }

	-- Auto-close brackets and such when hitting enter
	-- use 'rstacruz/vim-closer'
	use 'tpope/vim-endwise'

	-- Comment things in/out
	use {
		'numToStr/Comment.nvim',
		config = function() require('Comment').setup() end
	}

	-- Git improvements
	use 'tpope/vim-fugitive'
	use 'junegunn/gv.vim'
	use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }}

	-- Operate on "sandwhiched" text
	use {
		'machakann/vim-sandwich',
		config = 'vim.cmd[[runtime macros/sandwich/keymap/surround.vim]]'
	}

	-- Show undo history as a tree
	use 'mbbill/undotree'

	-- Adds a cx "exchange" operator to swap selections
	use 'tommcdo/vim-exchange'

	-- Expands on the idea of commands like di'
	use 'wellle/targets.vim'

	-- Better speed-dating
	use 'monaqa/dial.nvim' -- TODO: configure properly

	-- Align text
	use 'junegunn/vim-easy-align'

	-- Join/Split long lines in various languages
	use 'AndrewRadev/splitjoin.vim'

	-- Open more things with gx
	use 'stsewd/gx-extended.vim' -- TODO: lua port?

	-- Show color codes as their color
	use {
		'rrethy/vim-hexokinase',
		run = 'make hexokinase' 
	}

	-- Move blocks of selected text around
	use 'zirrostig/vim-schlepp'

	-- Misc ][ bindings
	-- use 'tpope/vim-unimpaired' -- TODO: create bindings from lua myself
	
	-- Make * search work in visual mode
	use 'bronson/vim-visual-star-search'

	-- Pencil to do "smart wrapping" in text and markdown files
	use 'preservim/vim-pencil'

	-- Emmet.vim for easier HTML writing
	use {
		'mattn/emmet-vim',
		ft = {'html', 'css'}
	}

	-- Display :StartupTime
	use 'dstein64/vim-startuptime'
end)

-- Reload packer on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('plugins.theme')
require('plugins.treesitter')
require('plugins.lsp')
require('plugins.git')

require("dirbuf").setup {
    show_hidden = false,
    sort_order = "directories_first",
    write_cmd = "DirbufSync",
}

require("toggleterm").setup{
	open_mapping = [[<C-\>]],
	direction = 'float',
	float_opts = {
		border = 'curved'
	}
}

require('telescope').setup{}
require('telescope').load_extension('fzf')

-- hexokinase
vim.g.Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'

-- wiki.vim
vim.g.wiki_root = "~/docs/memex"
vim.g.wiki_filetypes = {'md', 'wiki'}

-- emmet trigger key
vim.g.user_emmet_leader_key = '<C-S>'

-- vim-go
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_build_constraints = 1
