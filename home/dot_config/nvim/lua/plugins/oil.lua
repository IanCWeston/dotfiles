return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.icons" },
  lazy = false,
  keys = {
    { "-", "<CMD>vsplit | Oil<CR>", desc = "Oil split" },
    { "<leader>e", "<CMD>Oil --float<CR>", desc = "Explore filesytem (Oil)" },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["H"] = { "actions.parent", mode = "n" },
      ["L"] = { "actions.select", mode = "n" },
    },
    float = {
      -- Padding around the floating window
      padding = 2,
      -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = 0.8,
      max_height = 0.8,
      border = "rounded",
    },
  },
}
