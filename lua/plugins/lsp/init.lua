return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			{ "smjonas/inc-rename.nvim", config = true },
			"simrat39/rust-tools.nvim",
			"rust-lang/rust.vim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"b0o/schemastore.nvim",
			-- "jose-elias-alvarez/typescript.nvim",
		},
		config = function(plugin)
			require("plugins.lsp.servers").setup(plugin)
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			automatic_setup = true,
			automatic_install = true,
			ensure_installed = {
				"stylua",
				"ruff",
				"black",
				"flake8",
				"prettierd",
				"eslint_d",
				"elixir_ls",
				"rustywind",
				-- "pyright",
				"dockerfile-language-server",
			},
		},
		-- config = function(plugin)
		-- 	require("mason").setup()
		-- 	local mr = require("mason-registry")
		-- 	for _, tool in ipairs(plugin.ensure_installed) do
		-- 		local p = mr.get_package(tool)
		-- 		if not p:is_installed() then
		-- 			p:install()
		-- 		end
		-- 	end
		-- end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		config = function()
			local nls = require("null-ls")
			nls.setup({
				debounce = 150,
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.prettierd,
					nls.builtins.formatting.rustywind,
					nls.builtins.formatting.black,
					nls.builtins.formatting.mix,
					nls.builtins.formatting.prismaFmt,

					-- nls.builtins.diagnostics.ruff.with({ extra_args = { "--max-line-length=180" } }),
					nls.builtins.diagnostics.eslint_d.with({
						only_local = "node_modules/.bin",
					}),
					-- nls.builtins.diagnostics.flake8,
					nls.builtins.diagnostics.credo,

					nls.builtins.code_actions.eslint_d,
					-- require("typescript.extensions.null-ls.code-actions"),
				},
				root_dir = require("null-ls.utils").root_pattern("package.json", ".git"),
			})
		end,
	},

	{
		"utilyre/barbecue.nvim",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
		},
		config = function()
			require("barbecue").setup({
				theme = "catpuccin",
			})
		end,
	},

	-- inlay hints
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "LspAttach",
		opts = {},
		config = function(_, opts)
			require("lsp-inlayhints").setup(opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					require("lsp-inlayhints").on_attach(client, args.buf)
				end,
			})
		end,
	},
}
