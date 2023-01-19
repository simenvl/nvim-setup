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
		"vim",
		"prisma",
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	indent = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	matchup = {
		enable = true,
	},
	autoinstall = {
		enable = true,
	},
}

treesitter_configs.setup(options)
