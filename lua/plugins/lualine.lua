local status, lualine = pcall(require, "lualine")

if not status then
	return
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { -- Filetypes to disable lualine for.
			statusline = {}, -- only ignores the ft for statusline.
			winbar = {}, -- only ignores the ft for winbar.
		},
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
