local options = {
  backup = false, -- creates a backup file
  -- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 0, -- hide command line when not in use (requires v0.8+)
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  ignorecase = true, -- ignore case in search patterns
  laststatus = 3, -- set global statusline (requires v0.7+)
  list = true, -- allows showing hidden characters
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  pumheight = 10, -- pop up menu height
  relativenumber = false, -- set relative numbered lines
  scrolloff = 8, -- is one of my fav
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showtabline = 0, -- don't show the tabline
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true,
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 250, -- faster completion (4000ms default)
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.listchars:append("eol:↴")

-- vim.cmd("set whichwrap+=<,>,[,],h,l")
-- vim.cmd([[set iskeyword+=-]])
