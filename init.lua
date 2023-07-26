require("user.options")
require("config")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("user.autocmds")
		require("user.keymaps")
	end,
})
