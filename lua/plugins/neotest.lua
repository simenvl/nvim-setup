return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"marilari88/neotest-vitest",
		"haydenmeade/neotest-jest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-vitest"),
				-- require("neotest-jest"),
			},
			icons = {
				passed = "🟢",
				skipped = "⭕",
				failed = "🔴",
				unknown = "❔",
				running = "♻️",
			},
		})
	end,
}
