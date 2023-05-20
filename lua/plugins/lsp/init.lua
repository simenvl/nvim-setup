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
			{
				"b0o/SchemaStore.nvim",
				version = false, -- last release is way too old
			},
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
			},
			-- add any global capabilities here
			capabilities = {},
			-- Automatically format on save
			autoformat = true,
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "off",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							},
						},
					},
				},
				ansiblels = {},
				elixirls = {},
				astro = {},
				bashls = {},
				clangd = {},
				cssls = {
					settings = {
						css = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
						scss = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
						less = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
					},
				},
				tsserver = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = false,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = false,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				svelte = {},
				eslint = {
					settings = {
						workingDirectory = { mode = "auto" },
					},
				},
				html = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = { callSnippet = "Replace" },
							telemetry = { enable = false },
							hint = {
								enable = false,
							},
						},
					},
				},
				dockerls = {},
				vimls = {},
				tailwindcss = {},
				prismals = {},
				marksman = {},
			},
			setup = {
				lua_ls = function(_, _)
					local lsp_utils = require("plugins.lsp.utils")
					lsp_utils.on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "lua_ls" then
              vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end,
                { buffer = buffer, desc = "OSV Run" })
              vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end,
                { buffer = buffer, desc = "OSV Launch" })
            end
					end)
				end,
			},
		},
		config = function(plugin, opts)
			require("plugins.lsp.servers").setup(plugin, opts)
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
				-- "elixir_ls",
				"rustywind",
				-- "pyright",
				"dockerfile-language-server",
			},
		},
		config = function(_, opts)
			require("mason").setup()
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				debounce = 150,
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.prettierd.with({
						extra_filetypes = { "svelte" },
					}),
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
				},
				root_dir = require("null-ls.utils").root_pattern("package.json", ".git"),
			}
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		opts = { ensure_installed = nil, automatic_installation = true, automatic_setup = false },
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

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>cd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
			{ "<leader>cD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
		},
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
