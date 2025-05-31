local options = {
  -- Sync OS clipboard with neovim
  -- clipboard = "unnamedplus",

  -- Make line numbers default
  number = true,
  -- Set relative numbered lines
  -- relativenumber = true,

  -- Hide command line when not in use
  cmdheight = 0,

  -- Don't show mode since it's alredy in status line
  showmode = false,

  -- Show which line your cursor is on
  cursorline = true,

  -- Convert tabs to spaces
  expandtab = true,

  -- Set the encoding written to a file
  fileencoding = "utf-8",

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  ignorecase = true,
  smartcase = true,

  -- Set global statusline
  laststatus = 3,

  -- Sets how neovim will display certain whitespace characters in the editor
  list = true,

  -- Allow the mouse to be used in neovim
  mouse = "a",

  -- Pop up menu height
  pumheight = 10,

  -- Minimal number of screen lines to keep above and below the cursor
  scrolloff = 10,
  -- Same for side of cursor
  sidescrolloff = 10,

  -- Default number of spaces inserted for each indentation
  -- Insert 2 spaces for a tab
  shiftwidth = 2,
  tabstop = 2,

  -- Don't show the tabline
  --showtabline = 0,

  -- Keep signcolumn on by default
  signcolumn = "yes",

  -- Enable break indent
  breakindent = true,

  -- Smart indenting when starting a new line
  -- See `:help 'smartindent'`
  smartindent = true,

  -- Configure how splits should be opened
  splitright = true,
  splitbelow = true,

  -- Don't create swapfiles
  swapfile = false,

  -- Decrease update time
  updatetime = 250,

  -- Decrease mapped sequence wait time
  timeoutlen = 300,

  -- Enable persistent undo
  undofile = true,

  -- Display lines as one long line
  wrap = false,

  -- Preview substitutions live, as you type!
  inccommand = "split",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

--vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- vim.opt.listchars:append("eol:↴")

-- Nice and simple folding:
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

-- Default to Treesitter folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
