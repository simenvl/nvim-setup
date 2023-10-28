return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      },
    },
  },

  -- {
  --   "lewis6991/satellite.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  -- },

  {
    "dstein64/nvim-scrollview",
    event = "BufReadPre",
  },
}
