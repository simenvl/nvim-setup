return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-project.nvim",
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" }, -- find files within current working directory, respects .gitignore
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find string" }, -- find string in current working directory as you type
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" }, -- find string under cursor in current working directory
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List open buffers" }, -- list open buffers in current neovim instance
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "List available tags" }, -- list available help tags
		{ "<leader>fo", "<cmd>Telescope frecency theme=dropdown previewer=false<cr>", desc = "Recent" }, -- list recent files
		{
			"<leader>pp",
			function()
				require("telescope").extensions.project.project({ display_type = "minimal" })
			end,
			desc = "List",
		}, -- list projects

		-- telescope git commands (not on youtube nvim video)
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>" }, -- list all git commits (use <cr> to checkout) ["gc" for git commits]
		{ "<leader>gfc", "<cmd>Telescope git_bcommits<cr>" }, -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>" }, -- list git branches (use <cr> to checkout) ["gb" for git branch--[[ ] ]]
		{ "<leader>gs", "<cmd>Telescope git_status<cr>" }, -- list current changes per file with diff preview ["gs" for git status]
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local icons = require("config.icons")
		-- local fb_actions = require("telescope").extensions.file_browser.actions

		vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#f6c177" })

		telescope.setup({
			defaults = {
				prompt_prefix = " " .. icons.ui.Search .. "  ",
				selection_caret = icons.ui.ArrowCircleRight .. " ",
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
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = true,
					hidden = true,
					find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
				},
				git_files = {
					theme = "dropdown",
					previewer = false,
				},
				buffers = {
					theme = "dropdown",
					previewer = false,
				},
			},
			extensions = {
				file_browser = {
					theme = "dropdown",
					previewer = false,
					hijack_netrw = true,
					-- mappings = mappings,
				},
				project = {
					hidden_files = false,
					theme = "dropdown",
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("project")
	end,
}
