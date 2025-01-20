return {
  "OXY2DEV/markview.nvim",
  ft = "markdown",

  dependencies = {
    "echasnovski/mini.icons",
  },
  opts = function()
    local presets = require("markview.presets")
    return {
      headings = presets.headings.glow,
      horizontal_rules = presets.horizontal_rules.thin,
    }
  end,
  config = function(_, opts)
    require("markview").setup(opts)

    -- Extras
    require("markview.extras.headings").setup()
    require("markview.extras.checkboxes").setup()
  end,
}
