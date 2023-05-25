return {
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = true,
			show_current_context = true,
		},
	},

	-- noicer ui
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			views = {
				mini = {
					win_options = {
						winblend = 80,
					},
				},
			},
		},
		keys = {
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>snl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<leader>snh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll forward",
				mode = {
					"i",
					"n",
					"s",
				},
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll backward",
				mode = {
					"i",
					"n",
					"s",
				},
			},
		},
	},

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		-- dependencies = "nvim-tree/nvim-web-devicons",
		version = "*",
		-- keys = {
		-- 	{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
		-- 	{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		-- },
		opts = {
			options = {
				separator_style = "thin",
				show_tab_indicators = true,
				color_icons = true,
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("config.icons")
					local ret = (diag.error and icons.diagnostics.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.diagnostics.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
					},
				},
			},
		},
	},

	-- statusline
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = function()
	-- 		local icons = require("config.icons")
	--
	-- 		return {
	-- 			options = {
	-- 				theme = "auto",
	-- 				globalstatus = true,
	-- 				icons_enabled = true,
	-- 				disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "NvimTree" } },
	-- 				component_separators = "",
	-- 				section_separators = {
	-- 					left = "",
	-- 					right = "",
	-- 				},
	-- 			},
	-- 			sections = {
	-- 				lualine_a = {
	-- 					{
	-- 						"mode",
	-- 						separator = {
	-- 							left = "",
	-- 							right = "",
	-- 						},
	-- 					},
	-- 				},
	-- 				lualine_b = { "branch" },
	-- 				lualine_c = {
	-- 					{
	-- 						"diagnostics",
	-- 						symbols = {
	-- 							error = icons.diagnostics.Error,
	-- 							warn = icons.diagnostics.Warn,
	-- 							info = icons.diagnostics.Info,
	-- 							hint = icons.diagnostics.Hint,
	-- 						},
	-- 					},
	-- 					{
	-- 						"filetype",
	-- 						icon_only = true,
	-- 						separator = "",
	-- 						padding = {
	-- 							left = 1,
	-- 							right = 0,
	-- 						},
	-- 					},
	-- 					{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
	-- 				},
	-- 				lualine_x = {
	-- 					{
	-- 						"diff",
	-- 						symbols = {
	-- 							added = icons.git.added,
	-- 							modified = icons.git.modified,
	-- 							removed = icons.git.removed,
	-- 						},
	-- 					},
	-- 				},
	-- 				lualine_y = {
	-- 					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
	-- 					{ "location", padding = { left = 0, right = 1 } },
	-- 				},
	-- 				lualine_z = {
	-- 					{
	-- 						function()
	-- 							return " " .. os.date("%R")
	-- 						end,
	-- 						separator = {
	-- 							left = "",
	-- 							right = "",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 			extensions = { "nvim-tree", "toggleterm" },
	-- 		}
	-- 	end,
	-- },

	-- dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
			 ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
			 ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
			 ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
			 ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
			 ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
			 ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
      ]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
}
