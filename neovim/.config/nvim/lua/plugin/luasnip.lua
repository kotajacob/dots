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
