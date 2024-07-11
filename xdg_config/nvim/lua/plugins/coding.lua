return {
  -- SURROUND
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },
  -- COMMENT
  --   {
  --     "numToStr/Comment.nvim",
  --     event = "VeryLazy",
  --     opts = {
  --       ignore = "^$",
  --     },
  --   },
}
