local M = {}

function M.setup()
	-- Automatically update diagnostics
	vim.diagnostic.config({
		underline = true,
		-- update_in_insert = true,
		virtual_text = { spacing = 4, prefix = "●" },
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	local icons = require("config.icons").icons.diagnostics

	for type, icon in pairs(icons) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

return M
