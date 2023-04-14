-- return {
-- 	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
--
-- 	{
-- 		"mfussenegger/nvim-treehopper",
-- 		keys = { { "m", mode = { "o", "x" } } },
-- 		config = function()
-- 			vim.cmd([[
--         omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
--         xnoremap <silent> m :lua require('tsht').nodes()<CR>
--       ]])
-- 		end,
-- 	},
--
-- 	{
-- 		"nvim-treesitter/nvim-treesitter-context",
-- 		event = "BufReadPre",
-- 		config = true,
-- 	},
--
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		build = ":TSUpdate",
-- 		event = "BufReadPost",
-- 		dependencies = {
-- 			"nvim-treesitter/nvim-treesitter-textobjects",
-- 		},
-- 		config = function()
-- 			require("nvim-treesitter.configs").setup({
-- 				ensure_installed = {
-- 					"bash",
-- 					"c",
-- 					"cmake",
-- 					-- "comment", -- comments are slowing down TS bigtime, so disable for now
-- 					"cpp",
-- 					"css",
-- 					"diff",
-- 					"elixir",
-- 					"fish",
-- 					"gitignore",
-- 					"go",
-- 					"graphql",
-- 					"help",
-- 					"html",
-- 					"http",
-- 					"java",
-- 					"javascript",
-- 					"jsdoc",
-- 					"jsonc",
-- 					"latex",
-- 					"lua",
-- 					"markdown",
-- 					-- "markdown_inline",
-- 					"meson",
-- 					"ninja",
-- 					"nix",
-- 					"norg",
-- 					"org",
-- 					"php",
-- 					"python",
-- 					"query",
-- 					"regex",
-- 					"rust",
-- 					"scss",
-- 					"sql",
-- 					"svelte",
-- 					"teal",
-- 					"toml",
-- 					"tsx",
-- 					"typescript",
-- 					"vhs",
-- 					"vim",
-- 					"vue",
-- 					"wgsl",
-- 					"yaml",
-- 					"prisma",
-- 					-- "wgsl",
-- 					"json",
-- 				},
-- 				highlight = { enable = true },
-- 				-- indent = { enable = false },
-- 				query_linter = {
-- 					enable = true,
-- 					use_virtual_text = true,
-- 					lint_events = { "BufWrite", "CursorHold" },
-- 				},
-- 				playground = {
-- 					enable = true,
-- 					disable = {},
-- 					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
-- 					persist_queries = true, -- Whether the query persists across vim sessions
-- 					keybindings = {
-- 						toggle_query_editor = "o",
-- 						toggle_hl_groups = "i",
-- 						toggle_injected_languages = "t",
-- 						toggle_anonymous_nodes = "a",
-- 						toggle_language_display = "I",
-- 						focus_language = "f",
-- 						unfocus_language = "F",
-- 						update = "R",
-- 						goto_node = "<cr>",
-- 						show_help = "?",
-- 					},
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
--
return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- PERF: no need to load the plugin, if we only need its queries for mini.ai
					local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					local opts = require("lazy.core.plugin").values(plugin, "opts", false)
					local enabled = false
					if opts.textobjects then
						for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
							if opts.textobjects[mod] and opts.textobjects[mod].enable then
								enabled = true
								break
							end
						end
					end
					if not enabled then
						require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					end
				end,
			},
		},
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Schrink selection", mode = "x" },
		},
		---@type TSConfig
		opts = {
			highlight = { enable = true },
			indent = { enable = true, disable = { "python" } },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"c",
				"help",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
				"prisma",
				"regex",
				"rust",
				"scss",
				"sql",
				"svelte",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
