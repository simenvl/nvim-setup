return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		-- local fb_actions = require("telescope").extensions.file_browser.actions
		telescope.setup({
			defaults = {
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
	end,
}
