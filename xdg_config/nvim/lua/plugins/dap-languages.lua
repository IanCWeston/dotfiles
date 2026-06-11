return {
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class",  ft = "python" },
    },
    config = function()
      require("dap-python").setup("uv")
    end,
  },
  {
    "leoluz/nvim-dap-go",
    lazy = true,
    -- stylua: ignore
    keys = {
      { "<leader>dGt", function() require('dap-go').debug_test() end, desc = "Debug Test", ft = "go" },
    },
    opts = {},
  },
}
