return {
  -- AUTOPAIRS
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },

  -- SURROUND
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },
  -- COMMENT
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      ignore = "^$",
    },
  },
  -- QUICKFIX LIST
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
}
