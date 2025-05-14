return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      ui_select = true,
      sources = {
        buffers = {
          win = {
            input = {
              keys = {
                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
                ["D"] = { "bufdelete", mode = { "n" } },
              },
            },
          },
        },
      },
    },
  },
}
