-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Right>", ":vertical resize -2<CR>")
keymap("n", "<C-Left>", ":vertical resize +2<CR>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

-- Center search results
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")

-- Insert --
-- Alternate ESC
keymap("i", "jk", "<ESC>")
keymap("i", "kj", "<ESC>")

-- Tabout
keymap("i", "<Tab>", "<Right>")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Better paste
keymap("v", "p", '"_dP')

-- Telescope
keymap("n", "<c-t>", "<cmd>Telescope grep_string<cr>")
