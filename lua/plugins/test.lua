return {
  {
    "nvim-neotest/neotest",
    dependencies = { "haydenmeade/neotest-jest", "marilari88/neotest-vitest" },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tw",
        function()
          require("neotest").run.run({ jestCommand = "npx jest --watch" })
        end,
        desc = "Run test in watch mode",
      },
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm run test --",
          jestConfigFile = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
            end

            return vim.fn.getcwd() .. "jest.config.js"
          end,
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
      table.insert(opts.adapters, require("neotest-vitest"))
    end,
  },
}
