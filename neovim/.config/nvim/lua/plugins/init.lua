require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- "Libraries"
	use 'nvim-lua/plenary.nvim'
	use 'tpope/vim-repeat'
	use 'antoinemadec/FixCursorHold.nvim'

	-- Startup speed improvement (must call require before others plugins!)
	use {
		'lewis6991/impatient.nvim',
		config = function() require('impatient') end
	}

	-- Ability to reload neovim
	use 'famiu/nvim-reload'

	-- Colorscheme
	use '~/g/far-left'
	use 'RRethy/nvim-base16'
	use {
		'nvim-lualine/lualine.nvim',
		requires = "kyazdani42/nvim-web-devicons"
	}

	-- Advanced syntax highlighting and more...
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('plugins.treesitter')
		end
	}
	use {
		'lewis6991/spellsitter.nvim',
		config = function() require('spellsitter').setup() end
	}
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'nvim-treesitter/playground' -- Show highlight group w/ f12

	-- LSP
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
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
	use 'https://git.sr.ht/~sircmpwn/hare.vim'
	use 'mattn/emmet-vim'
	use 'jose-elias-alvarez/null-ls.nvim'
	use 'jose-elias-alvarez/nvim-lsp-ts-utils'
	use 'mfussenegger/nvim-jdtls'
	use {
		'fatih/vim-go',
		run = ':GoUpdateBinaries',
	}

	-- Fuzzy searcher
	use 'nvim-telescope/telescope.nvim'
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use '~/g/telescope-thesaurus.nvim'

	-- dirbuf as filemanager
	use "elihunter173/dirbuf.nvim"

	-- Wiki
	use { 'lervag/wiki.vim', ft = 'wiki' }
	use { '~/g/wiki-ft.vim', ft = 'wiki' }
	use 'jkramer/vim-checkbox' -- useful in non-wiki markdown too

	-- Comment things in/out
	use {
		'numToStr/Comment.nvim',
		config = function() require('Comment').setup() end
	}

	-- Git improvements
	use '~/git/vim-fugitive'
	use 'https://git.sr.ht/~willdurand/srht.vim'
	use 'junegunn/gv.vim'
	use 'tpope/vim-unimpaired'
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

	-- Operate on "sandwhiched" text
	use {
		'machakann/vim-sandwich',
		config = 'vim.cmd[[runtime macros/sandwich/keymap/surround.vim]]'
	}

	-- Improvements to marks
	use '~/g/bettermarks'

	-- Show undo history as a tree
	use 'mbbill/undotree'

	-- Show code outline window.
	use 'stevearc/aerial.nvim'

	-- Close all buffers except the current
	use 'vim-scripts/BufOnly.vim'

	-- Adds a cx "exchange" operator to swap selections
	use 'tommcdo/vim-exchange'

	-- Slightly improved %
	use 'andymass/vim-matchup'

	-- Expands on the idea of commands like di'
	use 'wellle/targets.vim'

	-- Better speed-dating
	use 'monaqa/dial.nvim'

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

	-- Move blocks of selected text around with arrow keys
	use 'zirrostig/vim-schlepp'

	-- Make * search work in visual mode
	use 'bronson/vim-visual-star-search'

	-- Fancy startup screen lol
	use 'goolord/alpha-nvim'

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
require('plugins.lsp')
require('plugins.git')

require("dirbuf").setup {
	show_hidden = false,
	sort_order = "directories_first",
	write_cmd = "DirbufSync",
}

require('telescope').setup {
	defaults = {
		path_display = { 'truncate' },
	}
}
require('telescope').load_extension('fzf')

-- mark visualizations
require('marks').setup()

-- code outline
require'aerial'.setup({
	on_attach = function(bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '_', '<cmd>AerialToggle<CR>', {})
	end
})


-- hexokinase
vim.g.Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'

-- wiki.vim
vim.g.wiki_root = "~/docs/memex"
vim.g.wiki_filetypes = { 'md', 'wiki' }

-- startup
require'alpha'.setup(require('plugins.dashboard').config)
