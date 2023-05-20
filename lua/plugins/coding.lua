return {
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	build = ":Copilot auth",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			panel = {
	-- 				enabled = true,
	-- 				auto_refresh = true,
	-- 				layout = {
	-- 					position = "right", -- | top | left | right
	-- 					ratio = 0.4,
	-- 				},
	-- 			},
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				keymap = {
	-- 					accept = "<C-y>",
	-- 					accept_word = false,
	-- 					accept_line = false,
	-- 					next = "<]]>",
	-- 					prev = "<[[>",
	-- 					dismiss = "<C-]>",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{ "github/copilot.vim", lazy = false },

	{ "windwp/nvim-ts-autotag", config = true },
	{ "danymat/neogen", config = true },

	{
		"windwp/nvim-autopairs",
		lazy = false,
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- treesitter integration
				disable_filetype = { "TelescopePrompt" },
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
					java = false,
				},

				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0, -- Offset from pattern match
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		lazy = false,
		config = function()
			require("nvim-surround").setup({
				mappings_style = "surround",
			})
		end,
	},

	-- neotest
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"marilari88/neotest-vitest",
			"haydenmeade/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-vitest"),
					-- require("neotest-jest"),
				},
				icons = {
					passed = "🟢",
					skipped = "⭕",
					failed = "🔴",
					unknown = "❔",
					running = "♻️",
				},
			})
		end,
	},
}
