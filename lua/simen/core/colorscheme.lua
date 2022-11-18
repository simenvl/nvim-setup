local status, _ = pcall(vim.cmd, "colorscheme darcula-solid")
if not status then
	print("Colorscheme not found!")
	return
end
