return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.icons" },
  lazy = false,
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    { "<leader>e", "<CMD>Oil --float<CR>", desc = "Explore filesytem" },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      -- WARN: Blocks macros in Oil buffer
      ["q"] = { "actions.close", mode = "n" },
      ["H"] = { "actions.parent", mode = "n" },
      ["L"] = { "actions.select", mode = "n" },
    },
  },
}
