local status, _ = pcall(vim.cmd, "colorscheme ayu")
if not status then
	print("Colorscheme not found!")
	return
end
