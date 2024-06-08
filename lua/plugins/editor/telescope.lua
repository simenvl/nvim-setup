return {
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = { width = 0.5 },
        },
        path_display = { "smart" },
        file_ignore_patterns = {
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
        },
        sorting_strategy = "ascending",
      },
      pickers = {
        find_files = {
          theme = "dropdown",
        },
      },
    },
  },
}
