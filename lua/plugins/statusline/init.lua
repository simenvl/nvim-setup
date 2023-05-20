return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("config.icons")

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					icons_enabled = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "NvimTree" } },
					component_separators = "",
					section_separators = {
						left = "",
						right = "",
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							separator = {
								left = "",
								right = "",
							},
						},
					},
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{
							"filetype",
							icon_only = true,
							separator = "",
							padding = {
								left = 1,
								right = 0,
							},
						},
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
					},
					lualine_x = {
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						{
							function()
								return " " .. os.date("%R")
							end,
							separator = {
								left = "",
								right = "",
							},
						},
					},
				},
				extensions = { "nvim-tree", "toggleterm" },
			}
		end,
	},
}
