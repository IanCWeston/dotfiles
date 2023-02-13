local is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()

local is_mac = vim.fn.has("macunix") == 1

local is_linux = not is_wsl and not is_mac

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

if is_linux then
  local packer_bootstrap = ensure_packer()
end

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

return packer.startup(function(use)
  use "wbthomason/packer.nvim"

  -- Prerequisites
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "MunifTanjim/nui.nvim"

  -- Statusline
  use "nvim-lualine/lualine.nvim"

  -- Colorschemes
  use "AbdelrahmanDwedar/awesome-nvim-colorschemes"
  -- use "rebelot/kanagawa.nvim"

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- External Diagnostics and Formatting
      {'jose-elias-alvarez/null-ls.nvim'}, -- Optional
  
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional
  
      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional, General Snippets
      {'bammab/vscode-snippets-for-ansible'}, -- Optional, Ansible Snippets
    }
  }

  use "folke/trouble.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Projects
  use "ahmedkhalf/project.nvim"

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Movement
  use "ggandor/leap.nvim"

  -- Editting support
  use "windwp/nvim-autopairs"
  use "abecodes/tabout.nvim"
  use "kylechui/nvim-surround"
  use "kevinhwang91/nvim-bqf"
  use "folke/todo-comments.nvim"

  -- Explorer / UI
  use { "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x"
  }
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use 'numToStr/Comment.nvim'
  use "NvChad/nvim-colorizer.lua"

  -- Future options
  -- use 'ThePrimeagen/harpoon'
  -- use 'mfussenegger/nvim-dap'
  -- use 'rcarriga/nvim-dap-ui'
  -- use "monaqa/dial.nvim"
  -- use "nvim-treesitter/nvim-treesitter-textobjects"
  -- use "windwp/nvim-spectre"
  -- use "karb94/neoscroll.nvim"
  -- use "b0o/SchemaStore.nvim"
  -- use "hrsh7th/cmp-cmdline"
  -- use "SmiteshP/nvim-navic"
  -- use "stevearc/aerial.nvim"
  -- use "stevearc/dressing.nvim"
end)
