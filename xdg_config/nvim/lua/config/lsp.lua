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
  "tailwindcss",
  -- docker
  "dockerls",
  -- html
  "emmet_language_server",
  "html",
  -- ci/cd
  "gh_actions_ls",
  "gitlab_ci_ls",
  -- go
  "golangci_lint_ls",
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

-- DIAGNOSTICS

local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = "󰅚 ",
  [vim.diagnostic.severity.WARN] = "󰀪 ",
  [vim.diagnostic.severity.INFO] = "󰋽 ",
  [vim.diagnostic.severity.HINT] = "󰌶 ",
}

local shorter_source_names = {
  ["Lua Diagnostics."] = "Lua",
  ["Lua Syntax Check."] = "Lua",
}

function diagnostic_format(diagnostic)
  return string.format(
    "%s %s (%s): %s",
    diagnostic_signs[diagnostic.severity],
    shorter_source_names[diagnostic.source] or diagnostic.source,
    diagnostic.code,
    diagnostic.message
  )
end

vim.diagnostic.config({
  severity_sort = true,
  -- underline = { severity = vim.diagnostic.severity.ERROR },
  underline = true,

  float = { border = "rounded", source = "if_many" },
  signs = {
    text = diagnostic_signs,
  },
  virtual_text = {
    -- source = "if_many",
    spacing = 4,
    prefix = "",
    format = diagnostic_format,
  },
  virtual_lines = {
    current_line = true,
    format = diagnostic_format,
  },
})
