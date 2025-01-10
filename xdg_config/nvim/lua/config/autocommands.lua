local _general_settings = vim.api.nvim_create_augroup("_general_settings", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "neo-tree",
    "tsplayground",
    "Markdown",
  },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { silent = true, buffer = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { silent = true, buffer = true })
    vim.bo.buflisted = false
  end,
  group = _general_settings,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Higlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
  group = _general_settings,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
  group = _general_settings,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  group = vim.api.nvim_create_augroup("_auto_resize", { clear = true }),
})
