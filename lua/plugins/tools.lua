return {
	-- markdown preview
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- better diffing
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		config = true,
		keys = { { "<leader>dw", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*", "!lazy" },
			buftype = { "*", "!prompt", "!nofile" },
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = false, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
				virtualtext = "■",
				tailwind = true,
			},
		},
	},

	--toggle term
	{
		"akinsho/toggleterm.nvim",
		-- version = "*",
		lazy = false,
		keys = {
			{ "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
		},
		opts = function()
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
				count = 9,
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "single",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
				-- function to run on closing the terminal
				-- on_close = function(term)
				-- 	vim.cmd("startinsert!")
				-- end,
			})

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>gg",
				"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
				{ noremap = true, silent = true }
			)

			return {
				size = 20,
				open_mapping = [[<c-t>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = false,
				shading_factor = 0.3,
				start_in_insert = true,
				persist_size = true,
				direction = "horizontal",

				float_opts = {
					border = "curved",
				},
			}
		end,
	},
}
