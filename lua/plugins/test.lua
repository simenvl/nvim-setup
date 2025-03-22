return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      {
        "thenbe/neotest-playwright",
        dependencies = "nvim-telescope/telescope.nvim",
        keys = {
          {
            "<leader>ta",
            function()
              require("neotest").playwright.attachment()
            end,
            desc = "Launch test attachment",
          },
          {
            "<leader>tw",
            "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
            desc = "Run jest test in watch mode",
          },
        },
      },
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        })
      )

      table.insert(
        opts.adapters,
        require("neotest-vitest")({
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules"
          end,
          is_test_file = function(file_path)
            if file_path == nil then
              return false
            end
            local is_test_file = false

            if string.match(file_path, "__tests__") then
              is_test_file = true
            end

            for _, x in ipairs({ "spec", "test" }) do
              for _, ext in ipairs({ "js", "jsx", "coffee", "ts", "tsx", "mjs", "mts" }) do
                if string.match(file_path, "%." .. x .. "%." .. ext .. "$") then
                  is_test_file = true
                  goto matched_pattern
                end
              end
            end
            ::matched_pattern::
            return is_test_file
          end,
        })
      )

      table.insert(
        opts.adapters,
        require("neotest-playwright").adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
            is_test_file = function(file_path)
              return string.match(file_path, "tests/e2e")
            end,
          },
          consumers = {
            playwright = require("neotest-playwright.consumers").consumers,
          },
        })
      )
    end,
  },
}
