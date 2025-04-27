-- local lsp_configs = {}
--
-- for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
--   local server_name = vim.fn.fnamemodify(f, ":t:r")
--   table.insert(lsp_configs, server_name)
-- end

-- vim.lsp.enable(lsp_configs)

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

-- -- Prefer LSP folding if client supports it
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--          local client = vim.lsp.get_client_by_id(args.data.client_id)
--          if client:supports_method('textDocument/foldingRange') then
--              local win = vim.api.nvim_get_current_win()
--              vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
--         end
--     end,
--  })

-- TODO: Create an LspRestart command
-- - Q: How to force-reload LSP?
-- - A: Stop all clients, then reload the buffer. >vim
--      :lua vim.lsp.stop_client(vim.lsp.get_clients())
--      :edit

-- TODO: Create an LspInfo command
-- 5. Check that LSP is active ("attached") for the buffer: >vim
--     :checkhealth vim.lsp
