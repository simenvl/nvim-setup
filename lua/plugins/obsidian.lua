return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		keys = {
			{
				"<leader>oc",
				"<cmd>ObsidianToggleCheckbox<CR>",
				desc = "Toggle checkbox",
			},
			{ "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes" },
			{ "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show location list of backlinks" },
			{ "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link under cursor" },
			{ "<leader>ot", "<cmd>ObsidianTemplate Core<cr>", desc = "Apply Core Template" },
		},
		opts = {
			workspaces = {
				-- {
				--   name = "personal",
				--   path = "~/vaults/personal",
				-- },
				{
					name = "work",
					path = "~/vaults/work",
				},
			},

			ui = { enable = false },
			preset = "mimic",

			-- see below for full list of options 👇
		},
		config = function(_, opts)
			require("obsidian").setup(opts)
		end,
	},
	{
		"folke/which-key.nvim",
		opts = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>o", desc = "Obsidian" },
			})
		end,
	},
}
