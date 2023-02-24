return {

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- kanagawa
  {
   "rebelot/kanagawa.nvim",
    lazy = true,
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
  },
}
