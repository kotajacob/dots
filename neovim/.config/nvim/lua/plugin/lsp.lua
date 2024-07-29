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

nvim_lsp.csharp_ls.setup {
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
