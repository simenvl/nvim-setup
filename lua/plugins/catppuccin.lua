return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 999,
	config = function()
		local catppuccin = require("catppuccin")
		catppuccin.setup({
			flavour = "macchiato",
			transparent_background = true,
		})
		vim.cmd([[colorscheme catppuccin]])
	end,
}
