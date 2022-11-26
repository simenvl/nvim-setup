local setup_colorizer, colorizer = pcall(require, "colorizer")

if setup_colorizer then
	return
end

colorizer.setup({})
