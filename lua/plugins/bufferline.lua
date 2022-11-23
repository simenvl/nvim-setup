local setup_bufferline, bufferline = pcall(require, "bufferline")

if not setup_bufferline then
	return
end

bufferline.setup()
