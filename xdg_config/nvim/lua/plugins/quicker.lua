return {
  "stevearc/quicker.nvim",
  ft = "qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>Q", function() require("quicker").toggle() end, desc = "Quickfix list" },
  },
}
