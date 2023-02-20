return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local nvimtree = require("nvim-tree")
		nvimtree.setup({
			renderer = {
				group_empty = true,

				highlight_opened_files = "all",
				icons = {
					webdev_colors = true,
					glyphs = {
						-- default = "",
						-- symlink = "",
						folder = {
							arrow_open = "",
							arrow_closed = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							untracked = "U",
							deleted = "",
							ignored = "◌",
						},
					},
				},
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			view = {
				adaptive_size = true,
				side = "left",
				width = 25,
				hide_root_folder = true,
			},
			update_focused_file = {
				enable = true,
				update_root = true,
				ignore_list = {},
			},

			git = {
				-- enbale = true,
				ignore = false,
			},

			filters = {
				dotfiles = false,
			},

			ignore_ft_on_setup = { "alpha" },
		})
	end,
}
