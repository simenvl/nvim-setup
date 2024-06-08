local keymap = vim.keymap.set

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        prismals = {},
        graphql = {},
      },

      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      -- inlay_hints = {
      --   enabled = true,
      -- },
    },
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {},
  },
}
