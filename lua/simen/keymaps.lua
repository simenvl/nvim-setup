vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Plugin keymaps

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<Cr>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch--[[ ] ]]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- lazygit
keymap.set("n", "<leader>lg", ":Lazygit<cr>")

-- toggleterm
keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>") -- open terminal in vertical split
keymap.set("t", "<leader>tt", [[<C-\><C-n>]]) -- close terminal in vertical split

-- Naviagate buffers
keymap.set("n", "<C-n>", ":bnext<CR>")
keymap.set("n", "<C-p>", ":bprevious<CR>")
keymap.set("n", "<leader>q", ":bdelete<CR>")

-- Todo comments
keymap.set("n", "<leader>tc", ":TodoTelescope<CR>")
keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Normal-mode commands
vim.keymap.set("n", "<M-j>", ":MoveLine(1)<CR>", opts)
vim.keymap.set("n", "<M-k>", ":MoveLine(-1)<CR>", opts)
vim.keymap.set("n", "<M-h>", ":MoveHChar(-1)<CR>", opts)
vim.keymap.set("n", "<M-l>", ":MoveHChar(1)<CR>", opts)

-- Visual-mode commands
vim.keymap.set("v", "<M-j>", ":MoveBlock(1)<CR>", opts)
vim.keymap.set("v", "<M-k>", ":MoveBlock(-1)<CR>", opts)
vim.keymap.set("v", "<M-h>", ":MoveHBlock(-1)<CR>", opts)
vim.keymap.set("v", "<M-l>", ":MoveHBlock(1)<CR>", opts)
