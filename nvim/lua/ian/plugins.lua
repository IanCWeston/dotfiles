--[=[
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
--]=]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Have packer manage itself

  -- Prerequisites
  -- use "nvim-lua/popup.nvim"
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("kyazdani42/nvim-web-devicons")

  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff
  use("kyazdani42/nvim-tree.lua") -- Explorer
  use("akinsho/bufferline.nvim") -- Tabline
  use("nvim-lualine/lualine.nvim") -- Status Line
  use("akinsho/toggleterm.nvim") -- Integrated terminal
  use("ahmedkhalf/project.nvim") -- Project manager
  use("lukas-reineke/indent-blankline.nvim") -- Adds indent lines
  use("goolord/alpha-nvim") -- Start screen
  use("folke/which-key.nvim") -- Keymap support
  use("lewis6991/impatient.nvim") -- Speed up startup
  -- use "antoinemadec/FixCursorHold.nvim"    -- This is needed to fix lsp doc highlight

  -- Colorschemes
  use("folke/tokyonight.nvim")
  -- use("rebelot/kanagawa.nvim")
  -- use("shaunsingh/nord.nvim")

  -- Completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp") -- nvim LSP completions
  use("hrsh7th/cmp-nvim-lua") -- nvim lua API completions

  -- Snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets") -- main set of snippets
  use("bammab/vscode-snippets-for-ansible") -- additional ansible snippets

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/nvim-lsp-installer") -- language server installer
  use("tamago324/nlsp-settings.nvim") -- language server settings defined in json format
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

  -- Telescope / Fuzzy Finder
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Treesitter
  use("nvim-treesitter/nvim-treesitter")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("nvim-treesitter/nvim-treesitter-textobjects")

  -- Git
  use("lewis6991/gitsigns.nvim")

  -- Extras
  use("folke/trouble.nvim")
  use("folke/todo-comments.nvim")

  use({
    "phaazon/hop.nvim",
    branch = "v1",
    keys = { "gh" },
    cmd = { "HopWord", "HopChar1" },
    config = function()
      require("hop").setup()
    end,
  })

  use("ggandor/lightspeed.nvim")
  use("AckslD/nvim-neoclip.lua")

  use({
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    config = function()
      require("colorizer").setup()
    end,
  })
  --[[
  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
--]]
end)
