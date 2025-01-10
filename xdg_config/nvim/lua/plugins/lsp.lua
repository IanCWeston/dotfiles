return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    lazy = true,
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr, remap = false }

        -- stylua: ignore start
        map("n", "K", function() vim.lsp.buf.hover() end, opts)
        map("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        map("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        map("n", "gd", function() vim.lsp.buf.definition() end, opts)
        map("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        map("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        map("n", "gl", function() vim.diagnostic.open_float() end, opts)
        map("n", "go", function() vim.lsp.buf.type_definition() end, opts)
        map("n", "gr", function() vim.lsp.buf.references() end, opts)
        map("n", "gS", function() vim.lsp.buf.signature_help() end, opts)
        map("n", "<M-a>", function() vim.lsp.buf.code_action() end, opts)
        -- stylua: ignore end
      end

      local servers = {
        pyright = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "off",
            },
          },
        },
        ruff = {},
        bashls = {},
        yamlls = {},
        ansiblels = {},
        jsonls = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          })
        end,
      })

      -- Add borders to pop-up windows
      require("lspconfig.ui.windows").default_options.border = "single"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      vim.diagnostic.config({
        virtual_text = true,
        float = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {},
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  },
}
