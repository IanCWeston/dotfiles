vim.lsp.enable({
  -- PYTHON
  "ruff",
  "ty",
  -- "pyrefly",
  -- "basedpyright",
  -- "jinja_lsp",

  -- SHELL
  "bashls",

  -- DOCKER
  "dockerls",

  -- CI/CD
  "gh_actions_ls",
  "gitlab_ci_ls",

  -- GO
  "gopls",
  "golangci_lint_ls",
  -- "htmx",
  -- "templ",

  -- HELM
  "helm_ls",

  -- JSON
  "jsonls",

  -- LUA
  "lua_ls",
  "stylua",

  -- MARKDOWN
  "marksman",
  "vale_ls",

  -- TOML
  "taplo",

  -- IaC
  "tofu_ls",
  -- "terraformls",

  -- YAML
  "yamlls",

  -- ANSIBLE
  "ansiblels",

  -- FORMATTING
  "oxfmt",
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
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client == nil then
      return
    end

    -- Prefer LSP folding if client supports it
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- Format on save if client supports it
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end

    local opts = { buffer = args.buf, remap = false }

    -- stylua: ignore start
    -- Navigation (single-result jumps → Snacks picker for multi-result UI)
    vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end,     { buffer = args.buf, desc = "Goto Definition" })
    vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end,    { buffer = args.buf, desc = "Goto Declaration" })

    -- Override 0.11 defaults that send to quickfix → use Snacks picker instead
    vim.keymap.set("n", "grr", function() Snacks.picker.lsp_references() end,     { buffer = args.buf, nowait = true, desc = "References" })
    vim.keymap.set("n", "gri", function() Snacks.picker.lsp_implementations() end,{ buffer = args.buf, desc = "Goto Implementation" })
    vim.keymap.set("n", "grt", function() Snacks.picker.lsp_type_definitions() end,{ buffer = args.buf, desc = "Goto Type Definition" })
    vim.keymap.set("n", "gO",  function() Snacks.picker.lsp_symbols() end,        { buffer = args.buf, desc = "LSP Symbols" })

    -- Diagnostics (keep float = true behavior, which defaults don't have)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1,  float = true }) end, opts)
    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)

    -- Format (no default exists for this)
    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end,
      { buffer = args.buf, remap = false, desc = "Format" })

    -- Left as global 0.11 defaults (grn, gra, gra visual, <C-s>, grx):
    -- grn  → vim.lsp.buf.rename()
    -- gra  → vim.lsp.buf.code_action()
    -- <C-s> → vim.lsp.buf.signature_help()
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

local function diagnostic_format(diagnostic)
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
