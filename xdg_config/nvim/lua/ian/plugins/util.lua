return {
  -- PLENARY
  { "nvim-lua/plenary.nvim", lazy = true },

  -- COLORIZER
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      filetypes = {
        "lua",
        "css",
        "html",
      },
    },
    config = function(_, opts)
      require("colorizer").setup(opts)
    end,
  },
}
