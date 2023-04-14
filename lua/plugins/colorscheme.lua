-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
--
-- 	config = function()
-- 		require("tokyonight").setup({
-- 			style = "night",
--
-- 			on_highlights = function(hl, c)
-- 				hl.CursorLineNr = { fg = c.orange, bold = true }
-- 				-- hl.LineNr = { fg = c.orange, bold = true }
-- 				hl.LineNrAbove = { fg = c.fg_gutter }
-- 				hl.LineNrBelow = { fg = c.fg_gutter }
-- 			end,
-- 		})
-- 		vim.cmd([[colorscheme tokyonight]])
-- 	end,
-- }

return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,

	opts = {
		flavour = "mocha",
	},
	config = function()
		vim.cmd([[colorscheme catppuccin]])
	end,
}
