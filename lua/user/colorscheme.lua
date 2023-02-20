local setup, colorscheme = pcall(require, "catppuccin")
if not setup then
	return
end

colorscheme.setup({
	transparent_background = true,
	integrations = {
		bufferline = true,
	},
})

vim.cmd.colorscheme("catppuccin")
