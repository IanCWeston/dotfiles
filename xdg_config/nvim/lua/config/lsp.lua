-- NOTE: Choosing to specify each server manually for now
-- for better management
vim.lsp.enable({
  -- ansible
  "ansiblels",
  -- python
  "basedpyright",
  "ruff",
  "jinja_lsp",
  -- bash
  "bashls",
  -- css
  "cssls",
  -- docker
  "dockerls",
  -- html
  "emmet_language_server",
  "html",
  -- ci/cd
  "gh_actions_ls",
  -- go
  "gopls",
  "htmx",
  "templ",
  -- helm
  "helm_ls",
  -- json
  "jsonls",
  -- http
  "kulala_ls",
  -- lua
  "lua_ls",
  -- markdown
  "marksman",
  -- sql
  "sqlls",
  -- toml
  "taplo",
  -- terraform
  "terraformls",
  -- typescript/javascript
  "ts_ls",
  -- yaml
  "yamlls",

  -- FIX: Disabled due to breaking config
  -- TODO: Copy over lspconfig util functions to resolve
  --
  -- "gitlab_ci_ls",
  -- "tailwindcss",
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     -- Unset 'formatexpr'
--     vim.bo[args.buf].formatexpr = nil
--     -- Unset 'omnifunc'
--     vim.bo[args.buf].omnifunc = nil
--     -- Unmap K
--     vim.keymap.del('n', 'K', { buffer = args.buf })
--   end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- Prefer LSP folding if client supports it
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Set LSP Keymaps
    local map = vim.keymap.set
    local opts = { buffer = args.buf, remap = false }

    -- stylua: ignore start
    -- map("n", "K", function() vim.lsp.buf.hover() end, opts)
    map("n", "[d", function() vim.diagnostic.jump({count=1, float=true}) end, opts)
    map("n", "]d", function() vim.diagnostic.jump({count=-1, float=true}) end, opts)
    map("n", "gd", function() vim.lsp.buf.definition() end, opts)
    map("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    map("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    map("n", "gl", function() vim.diagnostic.open_float() end, opts)
    map("n", "go", function() vim.lsp.buf.type_definition() end, opts)
    map("n", "gr", function() vim.lsp.buf.references() end, opts)
    map("n", "gS", function() vim.lsp.buf.signature_help() end, opts)
    -- map("n", "<M-a>", function() vim.lsp.buf.code_action() end, opts) -- replaced with gra
    -- stylua: ignore end
  end,
})

-- Add borders to lsp windows
local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover({
    max_width = 100,
    max_height = 14,
    border = "rounded",
  })
end

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

vim.api.nvim_create_user_command("LspRestart", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd.edit()
end, {})

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd.checkhealth("vim.lsp")
end, {})
