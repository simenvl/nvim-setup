return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	opts = {
		icon = {
			provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
				if node.type == "file" or node.type == "terminal" then
					local success, web_devicons = pcall(require, "nvim-web-devicons")
					local name = node.type == "terminal" and "terminal" or node.name
					if success then
						local devicon, hl = web_devicons.get_icon(name)
						icon.text = devicon or icon.text
						icon.highlight = hl or icon.highlight
					end
				end
			end,
		},
	},
}
