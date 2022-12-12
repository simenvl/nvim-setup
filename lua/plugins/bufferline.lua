local setup_bufferline, bufferline = pcall(require, "bufferline")

if not setup_bufferline then
	return
end

bufferline.setup({
	options = {
		show_buffer_close_icons = false,
		show_close_icon = true,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function()
			return " "
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		},
	},
})
