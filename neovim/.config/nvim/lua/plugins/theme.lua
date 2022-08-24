vim.o.background = "dark"
local left = require('far-left')
left.setup()
local left_theme = left.lualine()

local function lineCount()
	local total = vim.api.nvim_buf_line_count(0)
	return '%l' .. '/' .. total
end

local wcFiletypes = { 'md', 'markdown', 'txt', 'wiki' }
local function getWords()
	for _, v in pairs(wcFiletypes) do
		if v == vim.bo.filetype then
			if vim.fn.wordcount().visual_words == 1 then
				return tostring(vim.fn.wordcount().visual_words) .. " word"
			elseif not (vim.fn.wordcount().visual_words == nil) then
				return tostring(vim.fn.wordcount().visual_words) .. " words"
			else
				return tostring(vim.fn.wordcount().words) .. " words"
			end
		end
	end
	return ""
end

-- NOTE: Load colorscheme before lualine
require('lualine').setup {
	options = {
		theme = left_theme,
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
		globalstatus = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { { 'filename', path = 1 } },
		lualine_c = { { 'b:gitsigns_head', icon = '' } },
		lualine_x = { getWords },
		lualine_y = { 'diagnostics', 'filetype' },
		lualine_z = { lineCount }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
}
