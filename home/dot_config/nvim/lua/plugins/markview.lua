return {
  "OXY2DEV/markview.nvim",
  ft = "markdown", -- Not recommended but definitely speeds up load times
  cmd = { "Markview" },

  dependencies = {
    "echasnovski/mini.icons",
  },
  opts = function()
    local presets = require("markview.presets")
    return {
      markdown = {
        headings = presets.headings.glow,
        horizontal_rules = presets.horizontal_rules.thin,
      },
      -- Don't preview on buffer load. We handle this with a keymap
      preview = {
        enable = false,
      },
    }
  end,
  config = function(_, opts)
    require("markview").setup(opts)

    -- Extras
    require("markview.extras.headings").setup()
    require("markview.extras.checkboxes").setup()
  end,
}
