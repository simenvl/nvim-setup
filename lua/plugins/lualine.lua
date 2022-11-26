local status, lualine = pcall(require, "lualine")

if not status then
	return
end

-- -- custom config to lualine theme
-- local custom_gruvbox = require("lualine.themes.gruvbox")
-- local colors = require("simen.colors.gruvbox_colors")
--
-- custom_gruvbox.normal.a.bg = colors.accent
-- custom_gruvbox.insert.a.bg = colors.keyword
-- custom_gruvbox.visual.a.bg = colors.string
-- custom_gruvbox.command = {
-- 	a = { gui = "bold", fg = colors.bg, bg = colors.warning },
-- }

lualine.setup({
	options = {
		theme = "tokyonight",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
})
