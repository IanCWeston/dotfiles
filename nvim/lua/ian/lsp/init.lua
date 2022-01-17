local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("ian.lsp.lsp-installer")
require("ian.lsp.handlers").setup()
