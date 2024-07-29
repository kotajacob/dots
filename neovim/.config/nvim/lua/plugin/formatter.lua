-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
	logging = true,
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		json = {
			require("formatter.filetypes.json").prettier
		},
		css = {
			require("formatter.filetypes.css").prettier
		},
		html = {
			require("formatter.filetypes.html").prettier
		},
		gohtmltmpl = {
			require("formatter.filetypes.html").prettier
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettier
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettier
		},
	}
}

-- Run :Format on save
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
