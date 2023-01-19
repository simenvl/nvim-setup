local status, neo = pcall(require, "neotest")
if not status then
	return
end

neo.setup({
	addapters = {
		require("neotest-jest"),
		require("neotest-vitest"),
	},
	icons = {
		passed = "🟢",
		skipped = "⭕",
		failed = "🔴",
		unknown = "❔",
		running = "♻️",
	},
})
