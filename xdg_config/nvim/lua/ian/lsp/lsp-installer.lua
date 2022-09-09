require('mason').setup()

local lsp_status_ok, lsp_installer = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("ian.lsp.handlers").on_attach,
    capabilities = require("ian.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require("ian.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("ian.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  -- All other language servers use default configurations

  server:setup(opts)
end)
