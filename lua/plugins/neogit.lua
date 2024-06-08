return {
  {
    "NeogitOrg/neogit",
    event = { "BufReadPre" },
    keys = {
      { "<leader>gi", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = function()
      require("neogit").setup()
    end,
  },
}
