-- Install remote plugins
require 'paq' {
	'savq/paq-nvim';

	-- libraries
	'nvim-lua/plenary.nvim';

	-- mini
	'echasnovski/mini.nvim';

	-- display :StartupTime
	'dstein64/vim-startuptime';

	-- fuzzy searcher
	'nvim-telescope/telescope.nvim';
	{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };

	-- dirbuf as filemanager
	'elihunter173/dirbuf.nvim';

	-- git improvements
	'tpope/vim-fugitive';
	'lewis6991/gitsigns.nvim';

	-- bracket mappings and more
	'tpope/vim-unimpaired';

	-- lsp + autocomplete
	'neovim/nvim-lspconfig';
	'jose-elias-alvarez/null-ls.nvim';
	'stevearc/dressing.nvim';
	'hrsh7th/cmp-nvim-lsp';
	'hrsh7th/cmp-buffer';
	'hrsh7th/cmp-path';
	'hrsh7th/cmp-cmdline';
	'hrsh7th/nvim-cmp';
	'hrsh7th/cmp-vsnip';
	'hrsh7th/vim-vsnip';

	-- treesitter
	'nvim-treesitter/nvim-treesitter';

	-- langauge specific
	'fatih/vim-go';
	'lervag/wiki.vim';

	-- colors inline
	{ 'rrethy/vim-hexokinase', run = 'make' };

	-- "exchange" operator to swap selections
	'tommcdo/vim-exchange';

	-- Join/Split long lines in various languages
	'AndrewRadev/splitjoin.vim';

	-- Move blocks of selected text around with arrow keys
	'zirrostig/vim-schlepp';

	-- TODO
	-- bufonly
	-- status bar
	-- "open" with enter ("gf" or "gx" a link/file)
	-- marks: fix telescope list
	-- hare: language server?
	-- list synonyms with telescope?
	-- better autocomplete
	-- replace "unimpaired", "wiki", "vim-go"
}

-- Install my local plugins
vim.opt.runtimepath:append('~/g/far-left')
vim.opt.runtimepath:append('~/g/wiki-ft.vim')

-- Plugin configs
require('far-left').setup()

require('mini.ai').setup() -- a/i text object improvements
require('mini.align').setup() -- align with gaipi<space> or gaip-
require('mini.comment').setup() -- comment with gcc
require('mini.indentscope').setup() -- indent text object with ii
require('mini.jump').setup() -- improve f and t
require('mini.pairs').setup() -- autopairs
require('mini.surround').setup() -- sa (add), sd (delete), sr (replace)
require('mini.trailspace').setup() -- highlight trailing spaces

vim.g.miniindentscope_disable = true -- disable animation
vim.api.nvim_del_keymap("i", "`") -- disable ` auto pair


require('dirbuf').setup {
	show_hidden = false,
	sort_order = 'directories_first',
	write_cmd = 'DirbufSync',
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

require('dressing').setup({
	input = {
		insert_only = false,
		winblend = 0,
	},
	select = {
		telescope = require('telescope.themes').get_cursor({})
	}
})

require('gitsigns').setup {
	signs = {
		add          = {
			hl = 'GitSignsAdd',
			text = '│',
			numhl = 'GitSignsAddNr',
			linehl = 'GitSignsAddLn',
		},
		change       = {
			hl = 'GitSignsChange',
			text = '│',
			numhl = 'GitSignsChangeNr',
			linehl = 'GitSignsChangeLn',
		},
		delete       = {
			hl = 'GitSignsDelete',
			text = '│',
			numhl = 'GitSignsDeleteNr',
			linehl = 'GitSignsDeleteLn',
		},
		topdelete    = {
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

-- cmp and lsp
local cmp = require 'cmp'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		["<Tab>"] = cmp.mapping(function(fallback)
			-- This little snippet will confirm with tab, and if no entry is selected,
			-- will confirm the first item. Use C-N and C-P to change selected.
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.confirm()
				end
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
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
	capabilities = capabilities
}

nvim_lsp.clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

nvim_lsp.tsserver.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)
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

nvim_lsp.sumneko_lua.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
}

-- local null_ls = require("null-ls")

-- local haredoc = {
-- 	method = null_ls.methods.HOVER,
-- 	filetypes = { "hare" },
-- 	generator = {
-- 		fn = function(_, done)
-- 			local oldiskeyword = vim.opt_local.iskeyword
-- 			vim.opt_local.iskeyword:append(":")
-- 			local symbol = vim.fn.expand('<cword>')
-- 			vim.opt_local.iskeyword = oldiskeyword
--
-- 			require('plenary.job'):new({
-- 				command = 'haredoc',
-- 				args = { symbol },
-- 				on_exit = function(j, _)
-- 					done(j:result())
-- 				end,
-- 			}):start()
-- 		end,
-- 		async = true,
-- 	},
-- }

-- null_ls.setup({
-- 	sources = {
-- 		null_ls.builtins.diagnostics.shellcheck,
-- 		null_ls.builtins.formatting.shfmt,
-- 		null_ls.builtins.formatting.prettier,
-- 		null_ls.builtins.hover.dictionary,
-- 		haredoc,
-- 	},
-- 	on_attach = on_attach,
-- 	capabilities = capabilities
-- })
