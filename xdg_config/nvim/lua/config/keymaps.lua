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
map("n", "<leader>/", "<cmd>norm gcc<cr>", { desc = "Comment" })
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })
map("n", "<leader>c", "<cmd>bdelete!<CR>", { desc = "Close Buffer" })
map("n", "<leader>p", '"+p', { desc = "System Paste" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "System Yank" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

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

-- LSP
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
map("n", "<leader>la", function()
  vim.lsp.buf.code_action()
end, { desc = "Code Action" })
map("n", "<leader>ll", function()
  vim.lsp.codelens.run()
end, { desc = "CodeLens Action" })
map("n", "<leader>lr", function()
  vim.lsp.buf.rename()
end, { desc = "Rename" })

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

map("v", "<leader>/", "gc", { desc = "Comment", remap = true })
