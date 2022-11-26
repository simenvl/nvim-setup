local status_treesitter, _ = pcall(require, "nvim-treesitter")
if not status_treesitter then
	return
end

-- import nvim-treesitter plugin safely
local status, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
local options = {
	ensure_installed = {
		"bash",
		"javascript",
		"typescript",
		"json",
		"html",
		"css",
		"lua",
		"python",
		"tsx",
		"yaml",
	},
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},

	autoinstall = {
		enable = true,
	},

	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
}

treesitter_configs.setup(options)
