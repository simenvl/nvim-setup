return {
  {
    {
      "scottmckendry/cyberdream.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        -- Enable transparent background
        transparent = true,

        -- Enable italics comments
        italic_comments = true,
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      transparent_background = true, -- disables setting the background color.
    },
  },
  {
    "maxmx03/fluoromachine.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local fm = require("fluoromachine")

      fm.setup({
        glow = true,
        theme = "fluoromachine",
        transparent = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
