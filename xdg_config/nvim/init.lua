-- setup leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.lsp")
require("config.lazy")
