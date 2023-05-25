local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

---------------------
-- General Keymaps
---------------------

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "

-- use jk to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- delete single character without copying into register
keymap("n", "x", '"_x', opts)

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", opts) -- increment
keymap("n", "<leader>-", "<C-x>", opts) -- decrement

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Scrolling
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- window management
keymap("n", "<leader>sv", "<C-w>v", opts) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", opts) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>", opts) -- close current split window
keymap("n", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("n", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("n", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("n", "<C-l>", "<C-\\><C-n><C-w>l")

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

keymap("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
keymap("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Plugin keymaps

-- Vim-maximizer
keymap("n", "<leader>sm", ":MaximizerToggle<CR>", opts)

-- Naviagate buffers
keymap("n", "<C-n>", ":bnext<CR>", opts)
keymap("n", "<C-p>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("n", "<A-j", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- testing
keymap("n", "<leader>nto", ":lua require'neotest'.summary.toggle()<cr>", opts) -- jest - test file
keymap("n", "<leader>ntn", ":lua require'neotest'.run.run()<cr>", opts)
keymap("n", "<leader>nta", ":lua require'neotest'.run.run(vim.fn.expand'%')<cr>", opts) -- jest - test file
keymap("n", "<leader>nto", ":lua require'neotest'.output.open({ enter = true })<cr>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Neogen
keymap("n", "<leader>nf", ":lua require('neogen').generate()<CR>", opts)

-- Diagnostics
keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

-- save in insert mode
keymap("i", "<C-s>", "<cmd>:w<cr><esc>")
keymap("n", "<C-s>", "<cmd>:w<cr><esc>")
keymap("n", "<C-c>", "<cmd>normal ciw<cr>a")

-- Auto indent
keymap("n", "i", function()
	if #vim.fn.getline(".") == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true })
