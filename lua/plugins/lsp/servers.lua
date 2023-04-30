local M = {}

local servers = {
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
	cssls = {},
	dockerls = {},
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
	eslint = {},
	html = {},
	jsonls = {
		filetypes = { "json", "jsonc" },
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
	marksman = {},
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
	yamlls = {
		settings = {
			yaml = {
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
	lua_ls = {
		settings = {
			-- custom settings for lua
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
	vimls = {},
	tailwindcss = {},
	prismals = {},
}

local function lsp_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, bufnr)
		end,
	})
end

local function lsp_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

function M.setup(_)
	lsp_attach(function(client, buffer)
		require("plugins.lsp.format").on_attach(client, buffer)
		require("plugins.lsp.keys").on_attach(client, buffer)
		require("plugins.lsp.diagnostics").setup()
	end)

	require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
	require("mason-lspconfig").setup_handlers({
		function(server)
			local opts = servers[server] or {}
			opts.capabilities = lsp_capabilities()
			require("lspconfig")[server].setup(opts)
		end,
		["rust_analyzer"] = function(server)
			local rt = require("rust-tools")
			local opts = servers[server] or {}
			opts.capabilities = lsp_capabilities()
			rt.setup({ server = opts })
		end,
		-- ["typescript"] = function(server)
		-- 	local ts = require("typescript")
		-- 	local opts = servers[server] or {}
		-- 	opts.capabilities = lsp_capabilities()
		-- 	ts.setup({ server = opts })
		-- end,
	})
end

return M
