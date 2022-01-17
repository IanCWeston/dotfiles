local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  pumheight = 10, -- pop up menu height
  ignorecase = true, -- ignore case in search patterns
  smartcase = true,
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 250, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  cursorline = true, -- highlight the current line
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  termguicolors = true,
  mouse = "a", -- allow the mouse to be used in neovim
  list = true -- allows showing hidden characters
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- other options
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
-- vim.opt.shortmess:append "c"
