local servers = {
	"tsserver",
	"html",
	"cssls",
	"tailwindcss",
	"sumneko_lua",
	"emmet_ls",
	"pyright",
	"prismals",
}

local formatters = {
	-- list of formatters & linters for mason to install
	"prettier", -- ts/js formatter
	"stylua", -- lua formatter
	"eslint_d", -- ts/js linter
	"black",
	"flake8",
	"pylint",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})
require("mason-null-ls").setup({
	ensure_installed = formatters,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)

	-- configure typescript server with plugin
	typescript.setup({
		server = opts,
	})
end
