return {
  {
    "nvim-neotest/neotest",
    dependencies = { "thenbe/neotest-playwright", "haydenmeade/neotest-jest", "marilari88/neotest-vitest" },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        })
      )
    end,
  },
}
