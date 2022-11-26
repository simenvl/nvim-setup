require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors) end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(hl, c)
		local prompt = "#2d3149"
		hl.TelescopeNormal = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = prompt,
		}
		hl.TelescopePromptBorder = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePromptTitle = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
	end,
})

local status, tokyonight = pcall(vim.cmd, "colorscheme tokyonight")
if not status then
	return
end

-- require("gruvbox").setup({
-- 	undercurl = true,
-- 	underline = true,
-- 	bold = true,
-- 	italic = true,
-- 	strikethrough = true,
-- 	invert_selection = false,
-- 	invert_signs = false,
-- 	invert_tabline = false,
-- 	invert_intend_guides = false,
-- 	inverse = true, -- invert background for search, diffs, statuslines and errors
-- 	contrast = "hard", -- can be "hard", "soft" or empty string
-- 	overrides = {},
-- 	dim_inactive = false,
-- 	transparent_mode = false,
-- 	palette_overrides = {
-- 		dark0_hard = "#0A0E14",
-- 		dark0 = "#282828",
-- 		dark0_soft = "#32302f",
-- 		dark1 = "#00010A",
-- 		dark2 = "#504945",
-- 		dark3 = "#665c54",
-- 		dark4 = "#7c6f64",
-- 		light0_hard = "#f9f5d7",
-- 		light0 = "#fbf1c7",
-- 		light0_soft = "#f2e5bc",
-- 		light1 = "#ebdbb2",
-- 		light2 = "#d5c4a1",
-- 		light3 = "#bdae93",
-- 		light4 = "#a89984",
-- 		bright_red = "#fb4934",
-- 		bright_green = "#b8bb26",
-- 		bright_yellow = "#fabd2f",
-- 		bright_blue = "#83a598",
-- 		bright_purple = "#d3869b",
-- 		bright_aqua = "#8ec07c",
-- 		bright_orange = "#fe8019",
-- 		neutral_red = "#cc241d",
-- 		neutral_green = "#98971a",
-- 		neutral_yellow = "#d79921",
-- 		neutral_blue = "#458588",
-- 		neutral_purple = "#b16286",
-- 		neutral_aqua = "#689d6a",
-- 		neutral_orange = "#d65d0e",
-- 		faded_red = "#9d0006",
-- 		faded_green = "#79740e",
-- 		faded_yellow = "#b57614",
-- 		faded_blue = "#076678",
-- 		faded_purple = "#8f3f71",
-- 		faded_aqua = "#427b58",
-- 		faded_orange = "#af3a03",
-- 		gray = "#928374",
-- 	},
-- })
--
-- -- Theme: If you want to change the theme you need to
-- -- change this 2 things, colorscheme will apply the theme in the IDE
-- -- and you will also need to create a theme_colors to apply the theme
-- -- to the statusline and whichkey
-- local colorscheme = "gruvbox"
-- local colors = require("simen.colors.gruvbox_colors")
--
-- local function set_colors(fg, bg)
-- 	return "guifg=" .. fg .. " guibg=" .. bg
-- end
--
-- -- Applying colors
-- local api = vim.api
-- api.nvim_command("hi StatusDefault " .. set_colors(colors.fg, colors.bg))
-- api.nvim_command("hi StatusVimNormal " .. set_colors(colors.bg, colors.accent))
-- api.nvim_command("hi StatusVimInsert " .. set_colors(colors.bg, colors.neutral_blue))
-- api.nvim_command("hi StatusVimVisual " .. set_colors(colors.bg, colors.func))
-- api.nvim_command("hi StatusVimReplace " .. set_colors(colors.bg, colors.entity))
-- api.nvim_command("hi StatusVimEnter " .. set_colors(colors.bg, colors.string))
-- api.nvim_command("hi StatusVimMore " .. set_colors(colors.bg, colors.regexp))
-- api.nvim_command("hi StatusVimSelect " .. set_colors(colors.bg, colors.markup))
-- api.nvim_command("hi StatusVimCmd " .. set_colors(colors.bg, colors.keyword))
-- api.nvim_command("hi StatusVimShell " .. set_colors(colors.bg, colors.special))
-- api.nvim_command("hi StatusVimTerm " .. set_colors(colors.bg, colors.comment))
-- api.nvim_command("hi StatusModified " .. set_colors(colors.bg, colors.constant))
-- api.nvim_command("hi StatusLineNumber " .. set_colors(colors.bg, colors.operator))
-- api.nvim_command("hi StatusColumnNumber " .. set_colors(colors.bg, colors.error))
-- api.nvim_command("hi StatusFileInfo " .. set_colors(colors.keyword, colors.bg))
-- api.nvim_command("hi StatusGitInfo " .. set_colors(colors.bright_green, colors.bg))
-- api.nvim_command("hi StatusLSPProgress " .. set_colors(colors.neutral_blue, colors.bg))
-- api.nvim_command("hi StatusLSPError " .. set_colors(colors.error, colors.bg))
-- api.nvim_command("hi StatusLSPWarn " .. set_colors(colors.accent, colors.bg))
-- api.nvim_command("hi StatusLSPInfo " .. set_colors(colors.entity, colors.bg))
-- api.nvim_command("hi StatusLSPHin " .. set_colors(colors.tag, colors.bg))
-- api.nvim_command("hi StatusLSPStatus " .. set_colors(colors.tag, colors.bg))
-- api.nvim_command("hi StatusCwd " .. set_colors(colors.keyword, colors.bg))
-- api.nvim_command("hi StatusCursor " .. set_colors(colors.accent, colors.bg))
-- api.nvim_command("hi WhichKeyFloat " .. set_colors(colors.accent, colors.bg))
-- api.nvim_command("hi SessionName " .. set_colors(colors.string, colors.bg))
--
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
-- 	vim.notify("colorscheme " .. colorscheme .. " not found!")
-- 	return
-- end
