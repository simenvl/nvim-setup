return {
  {
    "windwp/nvim-ts-autotag",
    opts = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "prisma",
        "graphql",
      })
    end,
  },
}
