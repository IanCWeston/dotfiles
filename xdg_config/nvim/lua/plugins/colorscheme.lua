return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Trial Colorschemes
  { "rebelot/kanagawa.nvim", lazy = true },
  { "webhooked/kanso.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin" , lazy = true},
  { "everviolet/nvim", name = "evergarden" , lazy = true},
  { "rose-pine/neovim", name = "rose-pine" , lazy = true},
}
