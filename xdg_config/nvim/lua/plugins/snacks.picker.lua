return {
  "folke/snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader><space>", function() Snacks.picker.buffers({ layout = { preset = "select" } }) end, desc = "Buffers", },
    { "<leader>F", function() Snacks.picker.grep({ layout = { preset = "ivy" } }) end, desc = "Find Text", },
    { "<leader>f", function() Snacks.picker.files({ layout = { preset = "select" } }) end, desc = "Find files", },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Checkout branch", },
    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Checkout commit", },
    { "<leader>go", function() Snacks.picker.git_status() end, desc = "Open changed file", },
    { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workplace Symbols", },
    { "<leader>ld", function() Snacks.picker.diagnostics_buffer() end, desc = "Document Diagnostics", },
    { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols", },
    { "<leader>lw", function() Snacks.picker.diagnostics() end, desc = "Workspace Diagnostics", },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands", },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages", },
    { "<leader>sR", function() Snacks.picker.registers() end, desc = "Registers", },
    { "<leader>sb", function() Snacks.picker.git_branches() end, desc = "Checkout branch", },
    { "<leader>sc", function() Snacks.picker.colorschemes() end, desc = "Colorscheme", },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Find Help", },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps", },
    { "<leader>sr", function() Snacks.picker.recent() end, desc = "Open Recent File", },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
  },
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
