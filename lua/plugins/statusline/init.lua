local M = {
	"nvim-lualine/lualine.nvim",
}

function M.config()
	require("lualine").setup({
		options = {
			globalstatus = true,
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "▎", right = " " },
			disabled_filetypes = { "alpha", "dashboard" },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "filetype", icon_only = true }, "filename" },
			lualine_c = { { "branch", icon = { "", align = "left" } }, "diff", "diagnostics" },
			lualine_x = { "searchcount", "encoding", "fileformat", "diagnostics" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		extensions = { "nvim-tree", "fzf", "toggleterm" },
	})
end

return M
