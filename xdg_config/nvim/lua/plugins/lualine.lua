local fileformat = {
  "fileformat",
  symbols = {
    unix = "lf",
    dos = "crlf",
    mac = "cr",
  },
  cond = function()
    local bufnum = vim.api.nvim_get_current_buf()
    local format = vim.bo[bufnum].fileformat
    return format ~= "unix"
  end,
}

local encoding = {
  "encoding",
  cond = function()
    local bufnum = vim.api.nvim_get_current_buf()
    local format = vim.bo[bufnum].fileencoding
    return format ~= "utf-8"
  end,
}

local indent = {
  icon = "",
  function()
    local bufnum = vim.api.nvim_get_current_buf()
    return vim.bo[bufnum].shiftwidth
  end,
}

return {
  -- LUALINE
  "nvim-lualine/lualine.nvim",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      -- theme = "catppuccin",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "dashboard", "lazy", "alpha", "snacks_dashboard" },
        winbar = { "alpha", "dashboard", "snacks_dashboard" },
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
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        "mode",
        { "filename", path = 1, newfile_status = true },
        { "branch", icon = "" },
        "diff",
      },
      lualine_x = {
        "searchcount",
        "diagnostics",
        fileformat,
        encoding,
        indent,
        "filetype",
        { "lsp_status", symbols = { done = "", separator = "" } },
      },
      lualine_y = {},
      lualine_z = {},
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
  },
}
