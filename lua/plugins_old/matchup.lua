local status, matchup = pcall(require, "nvim-matchup")
if not status then
	return
end

matchup.setup({
	enable = true,
})
