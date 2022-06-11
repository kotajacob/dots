require 'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			disable = { "go" },

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aF"] = "@class.outer",
				["iF"] = "@class.inner",
				["ac"] = "@comment.outer",
				["ic"] = "@comment.outer",
				-- markdown
				["il"] = "@list_item.inner",
				["al"] = "@list_item.outer",
				["iC"] = "@code_block.inner", -- Doesn't apply to wiki.vim
				["aC"] = "@code_block.outer", -- wiki-ft has this already!
			},
		},
		move = {
			enable = true,
			disable = { "go" },
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]]"] = "@function.outer",
				["]m"] = "@class.outer",
			},
			goto_next_end = {
				["]["] = "@function.outer",
				["]M"] = "@class.outer",
			},
			goto_previous_start = {
				["[["] = "@function.outer",
				["[m"] = "@class.outer",
			},
			goto_previous_end = {
				["[]"] = "@function.outer",
				["[M"] = "@class.outer",
			},
		},
	},
}
