return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = {
        "graphql",
        "gql",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      root = { ".git", ".graphqlrc*", ".graphql.config.*", "graphql.config.*" },
    })
  end,

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        graphql = {
          cmd = { "graphql-lsp", "server", "-m", "stream" },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "graphql" } },
  },

  -- Linters & formatters
  {
    "williamboman/mason-lspconfig.nvim",
    opts = { ensure_installed = { "graphql" } },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- ...elided others
        "graphql-language-service-cli", -- required for graphql-lsp
      },
    },
  },
}
