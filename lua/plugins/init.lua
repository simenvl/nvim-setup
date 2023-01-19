return {
	"nvim-lua/plenary.nvim",
	{ "github/copilot.vim", lazy = false },
	{ "NvChad/nvim-colorizer.lua", ft = { "css" } },

	{
		"catppuccin/nvim",
		name = "catppuccin",
		event = "VeryLazy",
	},
	"nvim-telescope/telescope-project.nvim",
	"moll/vim-bbye",
	"kylechui/nvim-surround",
	"aserowy/tmux.nvim",
	{ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" },
}
