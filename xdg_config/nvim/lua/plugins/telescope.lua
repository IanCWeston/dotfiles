return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "debugloop/telescope-undo.nvim",
    },
    cmd = "Telescope",
    build = "make",
    version = false, -- telescope did only one release, so use HEAD for now
    opts = {
      defaults = {
        prompt_prefix = " ",
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
    config = function()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("undo")

      vim.keymap.set("n", "<c-t>", "<cmd>Telescope grep_string<cr>")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
}
