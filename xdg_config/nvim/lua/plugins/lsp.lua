return {
  {
    "williamboman/mason.nvim",
    version = "v1.*",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    lazy = false,
    config = true,
    init = function()
      -- Make mason packages available before loading it; allows to lazy-load mason.
      vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
      -- Do not crowd home directory with NPM cache folder
      vim.env.npm_config_cache = vim.env.HOME .. "/.cache/npm"
    end,
  },
}
