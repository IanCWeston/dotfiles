-- Shorten function name
local map = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Center search results
map("n", "n", "nzz")
map("n", "N", "Nzz")

map("n", "<space>X", "<cmd>source %<CR>", { desc = "Run lua file" })
map("n", "<space>x", ":.lua<CR>", { desc = "Run lua code line" })

-- Insert --
-- Alternate ESC
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- Tabout
map("i", "<Tab>", "<Right>")

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better paste
map("v", "p", '"_dP')

map("v", "<space>x", ":lua<CR>", { desc = "Run lua code selection" })
