return {
  "nvim-telescope/telescope.nvim",
  mappings = {
     config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions
    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["q"] = actions.close,
          },
        },
        file_ignore_patterns = { "node_modules", "deps", "_build", "priv", ".git" },
      }, 
    
  })
end
}}

