return {
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      -- local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        -- relculright = true,
        -- segments = {
        --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        --   {
        --     sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
        --     click = "v:lua.ScSa"
        --   },
        --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
        --   {
        --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
        --     click = "v:lua.ScSa"
        --   },
        -- }
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- Optional dependency
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({})
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  {
    "echasnovski/mini.move",
    version = "*",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<A-h>",
        right = "<A-l>",
        down = "<A-j>",
        up = "<A-k>",

        -- Move current line in Normal mode
        line_left = "<A-h>",
        line_right = "<A-l>",
        line_down = "<A-j>",
        line_up = "<A-k>",
      },
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji", "phenax/cmp-graphql" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "graphql" } }))

      -- opts.window = {
      --   documentation = cmp_window.bordered({
      --     winhighlight = "FloatBorder:CmpPmenu",
      --
      --   }),
      --   completion = cmp_window.bordered({
      --     winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:CmpPmenuSel,Search:None",
      --   }),
      -- }
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",

    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_hidden = false,
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    -- build = "cd app && yarn install",
    build = ":call mkdp#util#install()",
  },
}
