return {
	"nvim-lua/plenary.nvim",
	{ "github/copilot.vim", lazy = false },
	{ "NvChad/nvim-colorizer.lua", ft = { "css" } },
	"windwp/nvim-ts-autotag",

	{
		"catppuccin/nvim",
		name = "catppuccin",
		event = "VeryLazy",
	},
	"nvim-telescope/telescope-project.nvim",
	"moll/vim-bbye",
	"kylechui/nvim-surround",
	"aserowy/tmux.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	{ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" },

	{
		"windwp/nvim-autopairs",
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
		config = function()
			require("comment").setup({
				pre_hook = function(ctx)
					-- Only calculate commentstring for tsx filetypes
					if vim.bo.filetype == "typescriptreact" then
						local U = require("Comment.utils")

						-- Determine whether to use linewise or blockwise commentstring
						local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

						-- Determine the location where to calculate commentstring from
						local location = nil
						if ctx.ctype == U.ctype.blockwise then
							location = require("ts_context_commentstring.utils").get_cursor_location()
						elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
							location = require("ts_context_commentstring.utils").get_visual_start_location()
						end

						return require("ts_context_commentstring.internal").calculate_commentstring({
							key = type,
							location = location,
						})
					end
				end,
			})
		end,
	},
}
