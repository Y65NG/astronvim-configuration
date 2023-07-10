return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.motion.hop-nvim" },
  {
    "phaazon/hop.nvim",
    -- "hop-nvim",
    opts = {},
    keys = {
      {
        "s",
        function() require("hop").hint_words() end,
        mode = { "n" },
        desc = "Hop hint words",
      },
      {
        "<S-s>",
        function() require("hop").hint_vertical() end,
        mode = { "n" },
        desc = "Hop hint lines",
      },

      -- {
      --   "<S-s>",
      --   function()
      --     require("hop").hint_char1 {
      --       direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      --       current_line_only = false,
      --     }
      --   end,
      --   mode = { "n" },
      --   desc = "Hop hint lines",
      -- },
      {
        "s",
        function() require("hop").hint_words { extend_visual = true } end,
        mode = { "v" },
        desc = "Hop hint words",
      },
      {
        "<S-s>",
        function() require("hop").hint_vertical { extend_visual = true } end,
        mode = { "v" },
        desc = "Hop hint lines",
      },
    },
  },
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
