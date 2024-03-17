local Util = require("lazyvim.util")
local colors = require("config.colors")

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    config = function()
      local lualine = require("lualine")
      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      lualine.setup({
        options = {
          theme = "auto",
          component_separators = "|",
          section_separators = { right = "", left = "" },
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              icons_enabled = true,
              separator = { left = "", right = "" },
            },
          },
          lualine_b = {
            { "branch", padding = 2, icon = icons.kinds.Control },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              padding = 2,
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.ui.fg("Debug"),
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.ui.fg("Special"),
            },
            {
              "diff",
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
            { "location", padding = 1 },
          },
          lualine_y = {
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = { left = 2 },
            },
            {
              "filename",
              padding = 2,
            },
          },
          lualine_z = {
            {
              function()
                return " " .. os.date("%R")
              end,
              separator = { left = "", right = "" },
              color = { fb = colors.base, bg = colors.mauve },
            },
          },
        },
      })
    end,
  },
}
