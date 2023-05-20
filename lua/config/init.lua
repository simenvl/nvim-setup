local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Automatically source all configs in plugins directory.
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.extras.lang" },
		-- { import = "plugins.extras.ui" },
	},
	defaults = {
		lazy = true,
		version = nil,
	},

	-- checker = { enabled = true },
	performance = {
		cache = {
			enabled = true,
			-- disable_events = {},
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>")
