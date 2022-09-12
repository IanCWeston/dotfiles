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

  -- Tabline
  --use("akinsho/bufferline.nvim") -- Tabline

  -- Statusline
  use "nvim-lualine/lualine.nvim"

  -- Indents
  use "lukas-reineke/indent-blankline.nvim"

  -- Startup
  use "goolord/alpha-nvim"

  -- Colorschemes
  use "rebelot/kanagawa.nvim"

  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "saadparwaiz1/cmp_luasnip"

  -- Snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
  use "bammab/vscode-snippets-for-ansible"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json format
  use "jose-elias-alvarez/null-ls.nvim"
  use "folke/trouble.nvim"
  use "j-hui/fidget.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "nvim-telescope/telescope-ui-select.nvim"

  -- Projects
  use "ahmedkhalf/project.nvim"

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/nvim-treesitter-textobjects"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "sindrets/diffview.nvim"

  -- Editting support
  use "abecodes/tabout.nvim"
  use "monaqa/dial.nvim"
  use "kylechui/nvim-surround"
  use "windwp/nvim-autopairs"

  -- Comments
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

  -- Find and replace
  use "windwp/nvim-spectre"

  -- Keybinds
  use "folke/which-key.nvim"

  -- Explorer (currenting A/Bing two options)
  use "tamago324/lir.nvim"
  use "tamago324/lir-git-status.nvim"

  use { "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { "MunifTanjim/nui.nvim" }
  }

  -- Movement
  use "ggandor/leap.nvim"
  use "ThePrimeagen/harpoon"

  -- Session
  use "rmagatti/auto-session"
  use "rmagatti/session-lens"

  -- Quickfix
  use "kevinhwang91/nvim-bqf"

  -- Extras
  use "lewis6991/impatient.nvim"
  use "nathom/filetype.nvim"
  use "rcarriga/nvim-notify"
  use "Vhyrro/neorg"


  use { "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }

end)
