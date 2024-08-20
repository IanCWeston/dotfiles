return {
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
          -- theme = "catppuccin",
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
        extensions = {},
      }
    end,
  },
  -- NUI.NVIM
  { "MunifTanjim/nui.nvim", lazy = true },
}
