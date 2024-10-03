return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  keys = {
    {
      "[c",
      function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end,
      desc = "Jump to context",
    },
    {
      "<leader>uc",
      "<cmd>TSContextToggle<cr>",
      desc = "Toggle TS Context",
    },
  },
  opts = {},
}
