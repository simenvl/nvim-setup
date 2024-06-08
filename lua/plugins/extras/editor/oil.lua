return {
  -- which key integration
  {
    "folke/which-key.nvim",
    -- optional = true,
    opts = {
      defaults = {
        ["<leader>o"] = { name = "+oil" },
      },
    },
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      {
        "<leader>oo",
        function()
          require("oil").open_float()
        end,
        mode = { "n" },
        desc = "Open oil in current directory",
      },
      {
        "<leader>oO",
        function()
          require("oil").toggle_float(vim.fn.getcwd())
        end,
        mode = { "n" },
        desc = "Open oil in root directory",
      },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
}
