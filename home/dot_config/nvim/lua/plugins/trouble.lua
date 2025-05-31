return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  keys = {
    {
      "<leader>lt",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
  },
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
}
