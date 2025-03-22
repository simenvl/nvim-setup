local colors = {
  bg = "#16181a",
  bgAlt = "#1e2124",
  bgHighlight = "#3c4048",
  fg = "#ffffff",
  grey = "#7b8496",
  blue = "#5ea1ff",
  green = "#5eff6c",
  cyan = "#5ef1ff",
  red = "#ff6e5e",
  yellow = "#f1ff5e",
  magenta = "#ff5ef1",
  pink = "#ff5ea0",
  orange = "#ffbd5e",
  purple = "#bd5eff",
}
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local highlights = {
        CmpDocumentation = { fg = colors.grey },
        CmpDocumentationBorder = { fg = colors.grey },
        CmpGhostText = { fg = colors.grey },
        CmpItemAbbr = { fg = colors.fg },
        CmpItemAbbrDeprecated = { fg = colors.grey, strikethrough = true },
        CmpItemAbbrMatch = { fg = colors.pink },
        CmpItemAbbrMatchFuzzy = { fg = colors.purple },
        CmpItemKindVariable = { fg = colors.cyan },
        CmpItemKindInterface = { fg = colors.cyan },
        CmpItemKindText = { fg = colors.cyan },
        CmpItemKindFunction = { fg = colors.pink },
        CmpItemKindMethod = { fg = colors.pink },
        CmpItemKindKeyword = { fg = colors.fg },
        CmpItemKindProperty = { fg = colors.fg },
        CmpItemKindUnit = { fg = colors.fg },
        CmpItemMenu = { fg = colors.pink },
        CmpItemKindDefault = { fg = colors.pink },

        FloatBorder = { fg = colors.bgHighlight },
        CmpPmenuSel = { bg = colors.pink, fg = colors.bg },
        CmpPmenu = { fg = colors.fg, bg = nil },
      }

      for group, color in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, color)
      end

      local win_opt = {
        col_offset = 0,
        side_padding = 1,
        border = "single",
        scrollbar = "║",
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpPmenuSel,Search:None",
      }
      opts.window = {
        completion = cmp.config.window.bordered(win_opt),
        documentation = cmp.config.window.bordered(win_opt),
      }
    end,
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local highlights = {
        BlinkCmpLabel = { fg = colors.gray },
        BlinkCmpLabelDeprecated = { fg = colors.grey, strikethrough = true },
        BlinkCmpLabelMatch = { fg = colors.pink },
        BlinkCmpLabelMatchFuzzy = { fg = colors.purple },
        BlinkCmpLabelDetail = { fg = colors.pink },

        BlinkCmpKindVariable = { fg = colors.cyan },
        BlinkCmpKindInterface = { fg = colors.cyan },
        BlinkCmpKindText = { fg = colors.cyan },
        BlinkCmpKindFunction = { fg = colors.pink },
        BlinkCmpKindMethod = { fg = colors.pink },
        BlinkCmpKindKeyword = { fg = colors.fg },
        BlinkCmpKindProperty = { fg = colors.fg },
        BlinkCmpKindUnit = { fg = colors.fg },

        BlinkCmpMenuBorder = { fg = colors.bgHighlight, bg = "NONE" },
        BlinkCmpMenuSelection = { bg = colors.pink, fg = colors.bg },

        BlinkCmpDoc = { fg = colors.fg, bg = "NONE" },
        BlinkCmpDocBorder = { fg = colors.bgHighlight, bg = "NONE" },
        BlinkCmpDocCursorLine = { fg = colors.fg },

        BlinkCmpSignatureHelp = { fg = colors.fg, bg = "NONE" },
        BlinkCmpSignatureHelpBorder = { fg = colors.bgHighlight, bg = "NONE" },
      }

      for group, color in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, color)
      end

      opts.completion = {
        list = {
          selection = {
            auto_insert = true,
          },
        },
        menu = {
          border = "single",
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            -- columns = { { "kind_icon" }, { "label", gap = 1 } },
            -- components = {
            --   label = {
            --     text = function(ctx)
            --       return require("colorful-menu").blink_components_text(ctx)
            --     end,
            --     highlight = function(ctx)
            --       return require("colorful-menu").blink_components_highlight(ctx)
            --     end,
            --   },
            -- },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            border = "single",
          },
        },
      }
    end,
  },
}
