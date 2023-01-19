local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	print("Installing packer...")
	local packer_url = "https://github.com/wbthomason/packer.nvim"
	vim.fn.system({ "git", "clone", "--depth", "1", packer_url, install_path })
	print("Done.")

	vim.cmd("packadd packer.nvim")
	install_plugins = true
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	error("Couldn't load packer!")
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
	profiling = {
		enable = true,
		threshold = 1,
	},
})

packer.startup(function(use)
	-- Plugin manager
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	-- use({ "ellisonleao/gruvbox.nvim" })
	-- use({
	-- 	"rose-pine/neovim",
	-- 	as = "rose-pine",
	-- 	config = function()
	-- 		require("simen.colorscheme")
	-- 	end,
	-- })

	-- Tabs
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("plugins.bufferline")
		end,
	})
	use({ "moll/vim-bbye" })

	-- Explorer
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		tag = "nightly",
		config = function()
			require("plugins.nvim-tree")
		end,
	})

	-- Maximize splits
	use({ "szw/vim-maximizer" })

	-- Surround words with: "({[
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	})

	-- Comment stuff
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})

	-- Icons
	use({ "kyazdani42/nvim-web-devicons" })

	-- Telescope, Fzfinder
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-media-files.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim" })
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugins.project")
		end,
	})
	use({ "ibhagwan/fzf-lua" })

	-- Dashboard Init
	use({
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha")
		end,
	})

	-- Auto completions
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.nvim-cmp")
		end,
	})

	-- Shippets
	use({ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" })

	-- Manage and Install LSP servers
	use({
		"williamboman/mason.nvim",
	})
	use({ "williamboman/mason-lspconfig.nvim" })

	-- Config for LSP Servers
	-- use({
	-- 	"glepnir/lspsaga.nvim",
	-- 	-- config = function()
	-- 	-- 	require("plugins.lsp.lspsaga")
	-- 	-- end,
	-- })
	use({ "onsails/lspkind.nvim" })
	use({ "neovim/nvim-lspconfig" })
	use({ "jose-elias-alvarez/typescript.nvim" }) -- additional functionality for typescript server (e.g. rename file & update imports)

	-- Formatting
	use({ "jayp0521/mason-null-ls.nvim" })
	use({
		"jose-elias-alvarez/null-ls.nvim",
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "nvim-treesitter/playground" })

	-- Auto closing
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	})
	use({ "windwp/nvim-ts-autotag" })

	-- Git integration
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	})

	-- Color
	use({
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.colorizer")
		end,
	})

	-- UI
	use({
		"stevearc/dressing.nvim",
		config = function()
			require("plugins.dressing")
		end,
	})
	-- ["SmiteshP/nvim-navic"] = {
	-- 	config = function()
	-- 		require("plugins.navic")
	-- 	end,
	-- 	requires = { { "neovim/nvim-lspconfig" } },
	-- },
	use({ "kshenoy/vim-signature" })

	-- Match up blocks of code TODO: Check keybinds
	use({
		"andymass/vim-matchup",
		config = function()
			require("plugins.matchup")
		end,
	})

	-- toggle Term TODO: Check the keybinds
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggle-term")
		end,
	})

	-- Impatient optimize the startup time
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("plugins.impatient")
		end,
	})

	-- Tmux
	use({
		"aserowy/tmux.nvim",
		config = function()
			require("tmux").setup()
		end,
	})

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.lualine")
		end,
	})

	-- copilot
	use({ "github/copilot.vim" })

	-- indent markers
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.indent-blankline")
		end,
	})

	-- Testing
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
			"marilari88/neotest-vitest",
		},
		config = function()
			require("plugins.neotest")
		end,
	})

	-- Perfomance
	use({ "nathom/filetype.nvim" })

	-- DAP
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("plugins.dap")
		end,
	})
	use({
		"rcarriga/nvim-dap-ui",
		config = function()
			require("plugins.dap")
		end,
	})
	use({
		"ravenxrz/DAPInstall.nvim",
		config = function()
			require("plugins.dap")
		end,
	})

	-- JSDoc
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	})

	if install_plugins then
		require("packer").sync()
	end
end)

if install_plugins then
	print("==================================")
	print("    Plugins will be installed.")
	print("       After you press Enter")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
end
