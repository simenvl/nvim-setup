vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("user.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("user.autocmds")
		require("user.keymaps")
	end,
})
