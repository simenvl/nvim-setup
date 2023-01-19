return {
	-- neodev
	{
		"folke/neodev.nvim",
		opts = {
			debug = true,
			experimental = {
				pathStrict = true,
			},
			library = {
				runtime = "~/projects/neovim/runtime/",
			},
		},
	},

	-- tools
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"prettierd",
				"stylua",
				"selene",
				"luacheck",
				"eslint_d",
				"shellcheck",
				"deno",
				"shfmt",
				"black",
				"isort",
				"flake8",
			},
		},
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			---@type lspconfig.options
			servers = {
				ansiblels = {},
				bashls = {},
				clangd = {},
				cssls = {},
				dockerls = {},
				tsserver = {},
				svelte = {},
				eslint = {},
				html = {},
				gopls = {},
				marksman = {},
				pyright = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							checkOnSave = {
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
						},
					},
				},
				yamlls = {},
				sumneko_lua = {
					settings = { -- custom settings for lua
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								-- make language server aware of runtime files
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				teal_ls = {},
				vimls = {},
				-- tailwindcss = {},
			},
		},
	},

	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local nls = require("null-ls")
			nls.setup({
				debounce = 150,
				save_after_format = false,
				sources = {
					-- nls.builtins.formatting.prettierd,
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.fish_indent,
					-- nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
					-- nls.builtins.formatting.eslint_d,
					-- nls.builtins.diagnostics.shellcheck,
					nls.builtins.formatting.shfmt,
					nls.builtins.diagnostics.markdownlint,
					-- nls.builtins.diagnostics.luacheck,
					nls.builtins.formatting.prettierd.with({
						filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
					}),
					nls.builtins.diagnostics.selene.with({
						condition = function(utils)
							return utils.root_has_file({ "selene.toml" })
						end,
					}),
					-- nls.builtins.code_actions.gitsigns,
					nls.builtins.formatting.isort,
					nls.builtins.formatting.black,
					nls.builtins.diagnostics.flake8,
				},
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
			})
		end,
	},
}
