return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer", },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
    { "<leader>gj", function() require("gitsigns").nav_hunk("next") end, desc = "Next Hunk", },
    { "<leader>gk", function() require("gitsigns").nav_hunk("prev") end, desc = "Prev Hunk", },
    { "<leader>gl", function() require("gitsigns").blame_line() end, desc = "Blame", },
    { "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk", },
    { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk", },
    { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Toggle Stage Hunk", },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰐊" },
      topdelete = { text = "󰐊" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
  },
}
