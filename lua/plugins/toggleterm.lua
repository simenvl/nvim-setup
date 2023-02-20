local M = {
	"akinsho/toggleterm.nvim",
}

function M.config()
	require("toggleterm").setup({
		size = 20,
		open_mapping = [[<c-t>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "horizontal",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	})

	function _G.set_terminal_keymaps()
		local opts = { noremap = true }
		-- vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-p>", "<cmd>2ToggleTerm<CR>", opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-å>", "<cmd>3ToggleTerm<CR>", opts)
	end

	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		hidden = true,
		count = 99,
		direction = "float",
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.cmd("set laststatus=0")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
		-- function to run on closing the terminal
		on_close = function(_)
			vim.cmd("set laststatus=3")
		end,
	})

	function _LAZYGIT_TOGGLE()
		lazygit:toggle()
	end
end

return M
