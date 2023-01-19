vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("simen.autocmds")
require("simen.options")
require("simen.keymaps")

require("config.lazy")
