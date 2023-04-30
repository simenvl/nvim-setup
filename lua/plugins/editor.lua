return {
	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		config = true,
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			current_line_blame = true,
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		},
	},

	-- references
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
	},

	-- trouble
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				cmd = { "TroubleToggle", "Trouble" },
				opts = { use_diagnostic_signs = true },
				keys = {
					{
						"<leader>xx",
						"<cmd>TroubleToggle document_diagnostics<cr>",
						desc = "Document Diagnostics (Trouble)",
					},
					{
						"<leader>xX",
						"<cmd>TroubleToggle workspace_diagnostics<cr>",
						desc = "Workspace Diagnostics (Trouble)",
					},
					{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
					{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
					{
						"[q",
						function()
							if require("trouble").is_open() then
								require("trouble").previous({ skip_groups = true, jump = true })
							else
								vim.cmd.cprev()
							end
						end,
						desc = "Previous trouble/quickfix item",
					},
					{
						"]q",
						function()
							if require("trouble").is_open() then
								require("trouble").next({ skip_groups = true, jump = true })
							else
								vim.cmd.cnext()
							end
						end,
						desc = "Next trouble/quickfix item",
					},
				},
			})
		end,
	},
}
