return {
  "cbochs/grapple.nvim",
  dependencies = {
    { "nvim-mini/mini.icons", lazy = true },
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
        desc = "Mark file",
      },
      {
        "<leader>M",
        function()
          require("grapple").toggle_tags()
        end,
        desc = "Open marks window",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          require("grapple").select({ index = i })
        end,
        desc = "Jump to file " .. i,
      })
    end
    return keys
  end,
}
