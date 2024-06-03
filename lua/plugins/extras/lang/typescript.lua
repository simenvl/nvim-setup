-- local keymap = vim.keymap.set

return {
  {
    "marilari88/twoslash-queries.nvim",
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = true,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = true,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "typescript-language-server",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        -- formatters & linters
        "eslint_d",
        "prettierd",
        -- "biome",
      })
    end,
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   ft = {
  --     "javascript",
  --     "javascriptreact",
  --     "javascript.jsx",
  --     "typescript",
  --     "typescriptreact",
  --     "typescript.tsx",
  --   },
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   config = function()
  --     local api = require("typescript-tools.api")
  --     require("lazyvim.util.lsp").on_attach(function(client, bufnr)
  --       if client.name == "typescript-tools" then
  --         keymap(
  --           "n",
  --           "<leader>cX",
  --           "<cmd>TSToolsAddMissingImports<cr>",
  --           { buffer = bufnr, desc = "Add Missing Imports" }
  --         )
  --         keymap("n", "<leader>cI", "<cmd>TSToolsOrganizeImports<cr>", { buffer = bufnr, desc = "Organize Imports" })
  --         keymap("n", "<leader>cS", "<cmd>TSToolsSortImports<cr>", { buffer = bufnr, desc = "Sort Imports" })
  --         keymap("n", "<leader>cR", "<cmd>TSToolsRemoveUnused<cr>", { buffer = bufnr, desc = "Removed Unused" })
  --         -- keymap(
  --         --   "n",
  --         --   "<leader>cr",
  --         --   "<cmd>TSToolsRemoveUnusedImports<cr>",
  --         --   { buffer = bufnr, desc = "Removed Unused Imports" }
  --         -- )
  --         keymap(
  --           "n",
  --           "<leader>gd",
  --           "<cmd>TSToolsGoToSourceDefinition<cr>",
  --           { buffer = bufnr, desc = "Go To Source Definition" }
  --         )
  --         keymap("n", "<leader>cu", "<cmd>TSToolsFixAll<cr>", { buffer = bufnr, desc = "Fix All" })
  --         require("twoslash-queries").attach(client, bufnr)
  --       end
  --     end)
  --     require("typescript-tools").setup({
  --       settings = {
  --         tsserver_file_preferences = {
  --           includeInlayParameterNameHints = "all",
  --           includeCompletionsForModuleExports = true,
  --           quotePreference = "auto",
  --         },
  --         tsserver_format_options = {
  --           allowIncompleteCompletions = false,
  --           allowRenameOfImportPath = false,
  --         },
  --         expose_as_code_action = "all",
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     {
  --       "williamboman/mason.nvim",
  --       opts = function(_, opts)
  --         opts.ensure_installed = opts.ensure_installed or {}
  --         table.insert(opts.ensure_installed, "js-debug-adapter")
  --       end,
  --     },
  --   },
  --   opts = function()
  --     local dap = require("dap")
  --     if not dap.adapters["pwa-node"] then
  --       require("dap").adapters["pwa-node"] = {
  --         type = "server",
  --         host = "localhost",
  --         port = "${port}",
  --         executable = {
  --           command = "node",
  --           -- 💀 Make sure to update this path to point to your installation
  --           args = {
  --             require("mason-registry").get_package("js-debug-adapter"):get_install_path()
  --               .. "/js-debug/src/dapDebugServer.js",
  --             "${port}",
  --           },
  --         },
  --       }
  --     end
  --     for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  --       if not dap.configurations[language] then
  --         dap.configurations[language] = {
  --           {
  --             type = "pwa-node",
  --             request = "launch",
  --             name = "Launch file",
  --             program = "${file}",
  --             cwd = "${workspaceFolder}",
  --           },
  --           {
  --             type = "pwa-node",
  --             request = "attach",
  --             name = "Attach",
  --             processId = require("dap.utils").pick_process,
  --             cwd = "${workspaceFolder}",
  --           },
  --         }
  --       end
  --     end
  --   end,
  -- },
}
