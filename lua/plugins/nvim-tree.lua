local setup, nvimtree = pcall(require, "nvim-tree")

if not setup then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- change color for arrows in tree to light blue
-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#fabd2f ]])

-- configure nvim-tree
nvimtree.setup({
	renderer = {
		group_empty = true,

		highlight_opened_files = "all",
		icons = {
			webdev_colors = true,
			glyphs = {
				default = "",
				symlink = "",
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
