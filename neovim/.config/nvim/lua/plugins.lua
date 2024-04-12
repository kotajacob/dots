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
require('mini.operators').setup()    -- exchange, evaluate, repeat, multiply
require('mini.pairs').setup()        -- open and close pairs
require('mini.splitjoin').setup()    -- split and join long lines
require('mini.surround').setup()     -- sa (add), sd (delete), sr (replace)
require('mini.trailspace').setup()   -- highlight trailing spaces
vim.g.miniindentscope_disable = true -- disable animation

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
add('folke/trouble.nvim')
add('elihunter173/dirbuf.nvim')
add('rmagatti/gx-extended.nvim')
add('L3MON4D3/LuaSnip')
add('rafamadriz/friendly-snippets')

-- Vim script plugins
add('tpope/vim-fugitive')
add('mattn/emmet-vim')
add('lervag/file-line')
add('fatih/vim-go')
add('lervag/wiki.vim')
add('lervag/wiki-ft.vim')

-- LSP settings
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

local nvim_lsp = require("lspconfig")

nvim_lsp.gopls.setup {
	on_attach = on_attach,
}

nvim_lsp.rust_analyzer.setup {
	on_attach = on_attach,
}

nvim_lsp.clangd.setup {
	on_attach = on_attach,
}

nvim_lsp.zls.setup {
	on_attach = on_attach,
}

nvim_lsp.gdscript.setup {
	on_attach = on_attach,
}

nvim_lsp.kotlin_language_server.setup {
	on_attach = on_attach,
}

-- nvim_lsp.denols.setup {
-- 	on_attach = on_attach,
-- }

nvim_lsp.tsserver.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {
			silent = true,
		})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspRenameFile<CR>", {
			silent = true,
		})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "go", ":TSLspImportAll<CR>", {
			silent = true,
		})
		on_attach(client, bufnr)
	end,
})

nvim_lsp.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					'vim',
					'MiniDeps',
					'MiniDiff',
					'MiniFiles',
					'MiniTrailspace'
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),

				-- Stop offering to "change workspace settings"
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
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

require('telescope').setup {
	defaults = {
		path_display = { 'truncate' },
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "bottom",
			preview_cutoff = 1, -- Show preview (unless previewer = false)

			width = function(_, max_columns, _)
				return math.min(max_columns, 160)
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

require("trouble").setup({
	icons = false,
	fold_open = "v",   -- icon used for open folds
	fold_closed = ">", -- icon used for closed folds
	indent_lines = false, -- add an indent guide below the fold icons
	signs = {
		-- icons / text used for a diagnostic
		error = "error",
		warning = "warn",
		hint = "hint",
		information = "info"
	},
	use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})

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

require('dirbuf').setup {
	show_hidden = true,
	sort_order = 'directories_first',
	write_cmd = 'DirbufSync',
}

local ls = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI",
}

-- Open / Next
vim.keymap.set(
	{ "i", "s" },
	"<C-J>",
	function() ls.expand_or_jump() end,
	{ silent = true }
)

-- Prev
vim.keymap.set(
	{ "i", "s" },
	"<C-K>",
	function() ls.jump(-1) end,
	{ silent = true }
)

-- List options
vim.keymap.set({ "i", "s" }, "<C-L>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })
