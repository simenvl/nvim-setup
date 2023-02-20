return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		-- local fb_actions = require("telescope").extensions.file_browser.actions
		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = "❯ ",
				mappings = {
					n = {
						["q"] = actions.close,
					},
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
				file_ignore_patterns = { "node_modules", "deps", "_build", "priv", ".git" },
			},
		})
		telescope.load_extension("fzf")
	end,
}
