return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    -- TODO: Implement the util functions from LazyVim to allow for advanced key setup
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua
    keys = function(_, keys)
      -- -- Populate the keys based on the user's options
      -- local opts = LazyVim.opts("mini.surround")
      -- local mappings = {
      --   { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
      --   { opts.mappings.delete, desc = "Delete Surrounding" },
      --   { opts.mappings.find, desc = "Find Right Surrounding" },
      --   { opts.mappings.find_left, desc = "Find Left Surrounding" },
      --   { opts.mappings.highlight, desc = "Highlight Surrounding" },
      --   { opts.mappings.replace, desc = "Replace Surrounding" },
      --   { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      -- }
      -- mappings = vim.tbl_filter(function(m)
      --   return m[1] and #m[1] > 0
      -- end, mappings)
      -- return vim.list_extend(mappings, keys)
    end,
    opts = {
      -- NOTE: Using vim-surround mappings
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "cs", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
      search_method = "cover_or_next",
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          -- TODO: Review function
          -- g = LazyVim.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- LazyVim.on_load("which-key.nvim", function()
      --   vim.schedule(function()
      --     LazyVim.mini.ai_whichkey(opts)
      --   end)
      -- end)
    end,
  },
}
