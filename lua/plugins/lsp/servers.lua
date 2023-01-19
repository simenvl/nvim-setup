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
	astro = {},
	bashls = {},
	clangd = {},
	cssls = {},
	dockerls = {},
	tsserver = {},
	svelte = {},
	eslint = {},
	html = {},
	jsonls = {
		on_new_config = function(new_config)
			new_config.settings.json.schemas = new_config.settings.json.schemas or {}
			vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
		end,
		settings = {
			json = {
				format = {
					enable = true,
				},
				validate = { enable = true },
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
	vimls = {},
	tailwindcss = {},
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
	})
end

return M
