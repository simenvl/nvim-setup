return {
  {
    "dstein64/nvim-scrollview",
    event = "BufReadPre",
  },

  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = { animation = require("mini.indentscope").gen_animation.none() },
    },
  },
}
