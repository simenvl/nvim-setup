return {
	"atiladefreitas/dooing",
	config = function()
		require("dooing").setup({
			-- your custom config here (optional)
		})
	end,
	keys = {
		{ "<leader>td", desc = "Toggle Todo List" },
	},
}
