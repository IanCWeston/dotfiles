return {
  -- ALPHA
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":edit ~/.config/nvim/init.lua <CR>"),
        dashboard.button("l", "鈴 Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }

      local function footer()
        return "I   Efficiency"
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
    end,
  },
  -- LUALINE
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(plugin)
      local custom_fileformat = {
        "fileformat",
        symbols = {
          unix = "lf",
          dos = "crlf",
          mac = "cr",
        },
      }

      return {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "|" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "dashboard", "lazy", "alpha" },
            winbar = { "alpha" },
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "diff", "diagnostics", "%=", "filename" },
          lualine_x = { "searchcount", "encoding", custom_fileformat, "filetype" },
          lualine_y = {},
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {
          lualine_c = { "%=", { "filename", path = 3 } },
        },
        inactive_winbar = {
          lualine_c = { "%=", "filename" },
        },
        extensions = {},
      }
    end,
  },
  -- INDENT BLANKLINE
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = true,
      show_current_context_start = true,
    },
  },
  -- NVIM-WEB-DEVICONS
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- NUI.NVIM
  { "MunifTanjim/nui.nvim", lazy = true },
}
