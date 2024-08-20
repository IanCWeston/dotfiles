return {
  "cbochs/grapple.nvim",
  dependencies = {
    { "echasnovski/mini.icons", lazy = true },
  },
  opts = {
    scope = "git", -- also try out "git_branch"
  },
  event = { "BufReadPost", "BufNewFile" },
  keys = function()
    local keys = {
      {
        "<leader>m",
        function()
          require("grapple").toggle()
        end,
        desc = "Grapple toggle tag",
      },
      {
        "<leader>M",
        function()
          require("grapple").toggle_tags()
        end,
        desc = "Grapple open tags window",
      },
    }

    for i = 1, 4 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          require("grapple").select({ index = i })
        end,
        desc = "Grapple to File " .. i,
      })
    end
    return keys
  end,
}
