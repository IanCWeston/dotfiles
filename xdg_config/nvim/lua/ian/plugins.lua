local is_wsl = (function() 
  local output = vim.fn.systemlist "uname -r" 
  return not not string.find(output[1] or "", "WSL")
end)() 

local is_mac = vim.fn.has("macunix") == 1

local is_linux = not is_wsl and not is_mac

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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
  use("rebelot/kanagawa.nvim")

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
  use("nathom/filetype.nvim")
  use("folke/trouble.nvim")
  use("folke/todo-comments.nvim")
  use("ggandor/lightspeed.nvim")
  use("simrat39/symbols-outline.nvim")

  use({
    "phaazon/hop.nvim",
    branch = "v1",
    cmd = { "HopWord", "HopChar1" },
    config = function()
      require("hop").setup() -- trying out packer config ability
    end,
  })

  use({
    "AckslD/nvim-neoclip.lua", -- we may not need this
    config = function()
      require("neoclip").setup()
    end,
  })

  use({
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    config = function()
      require("colorizer").setup()
    end,
  })

  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
    end,

  use("abecodes/tabout.nvim")
  })
  --[[
  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
--]]
end)
