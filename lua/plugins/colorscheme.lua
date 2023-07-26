return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,

		opts = function()
			return {
				flavour = "mocha",

				-- vim.cmd([[colorscheme catppuccin]]),
			}
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,

		config = function()
			require("tokyonight").setup({
				style = "night",

				on_highlights = function(hl, c)
					hl.CursorLineNr = { fg = c.orange, bold = true }
					-- hl.LineNr = { fg = c.orange, bold = true }
					hl.LineNrAbove = { fg = c.fg_gutter }
					hl.LineNrBelow = { fg = c.fg_gutter }
				end,
			})

			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		priority = 1000, -- make sure to load this before all the other start plugins

		config = function()
			-- vim.cmd([[colorscheme rose-pine]])
		end,
	},
}
