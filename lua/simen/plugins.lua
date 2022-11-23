-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	-- Colorscheme
	use("ayu-theme/ayu-vim")

	-- Tmux & split window managements
	use("christoomey/vim-tmux-navigator")

	-- maximizes and restores current window
	use("szw/vim-maximizer")

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})

	-- file explorer
	use({
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("plugins.nvim-tree")
		end,
	})

	-- vs-code like icons
	use("nvim-tree/nvim-web-devicons")

	-- statusline
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		config = function()
			require("plugins.telescope")
		end,
	}) -- fuzzy finder

	-- autocompletion
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.nvim-cmp")
		end,
	}) -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use({
		"williamboman/mason.nvim",
		config = function()
			require("plugins.lsp.mason")
		end,
	}) -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp.lspconfig")
		end,
	}) -- easily configure language servers

	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("plugins.lsp.lspsaga")
		end,
	}) -- enhanced lsp uis

	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.lsp.null-ls")
		end,
	}) -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	}) -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	}) -- show line modifications on left hand side

	-- github copilot
	use("github/copilot.vim")

	-- markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	--terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("plugins.toggleterm")
		end,
	})

	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
	})

	-- which-key
	use({
		"folke/which-key.nvim",
		config = function()
			require("plugins.whichkey")
		end,
	})

	-- dashboard
	use({
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha")
		end,
	})

	-- gruvbox theme
	use({ "ellisonleao/gruvbox.nvim" })

	-- changing the way of how to use tabs on neovim
	use("tiagovla/scope.nvim")

	-- todo comments
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- dressing
	use({
		"stevearc/dressing.nvim",
		config = function()
			require("plugins.dressing")
		end,
	})

	-- colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- matchup
	use({
		"andymass/vim-matchup",
	})

	-- notify
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("plugins.notify")
		end,
	})

	-- nvim-navic - statusline / winbar
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
