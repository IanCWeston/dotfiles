return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      -- WARN: Blocks macros in Oil buffer
      ["q"] = { "actions.close", mode = "n" },
      ["h"] = { "actions.parent", mode = "n" },
      ["l"] = { "actions.select", mode = "n" },
    },
  },
}
