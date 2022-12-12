local setup, _ = pcall(vim.cmd, "colorscheme catppuccin")
if not setup then
	return
end
