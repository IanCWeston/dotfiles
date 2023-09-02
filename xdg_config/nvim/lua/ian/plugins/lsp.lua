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
      { "folke/neodev.nvim" },
    },
    config = function()
      require("neodev").setup({})

      local lspconfig = require("lspconfig")
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local map = vim.keymap.set
          local opts = { buffer = event.buf, remap = false }

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
        end,
      })

      local default_setup = function(server)
        lspconfig[server].setup({})
      end

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "bashls",
          "yamlls",
          "ansiblels",
          "jsonls",
          "dockerls",
        },
        handlers = {
          default_setup,
          pyright = function()
            require("lspconfig").pyright.setup({
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    diagnosticMode = "workspace",
                    inlayHints = {
                      variableTypes = true,
                      functionReturnTypes = true,
                    },
                  },
                },
              },
            })
          end,
        },
      })

      vim.diagnostic.config({
        virtual_text = true,
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {},
  },
  -- TODO: Look into alternative formatting options
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      local diagnostics = null_ls.builtins.diagnostics
      local formatting = null_ls.builtins.formatting

      null_ls.setup({
        sources = {
          diagnostics.ruff,
          diagnostics.shellcheck,
          formatting.prettier.with({
            extra_filetypes = { "toml", "xml" },
            extra_args = { "--no-semi", "--single-quote" },
          }),
          formatting.ruff.with({ extra_args = { "--fixable", "I" } }),
          formatting.black.with({ extra_args = { "--fast" } }),
          formatting.stylua,
        },
      })
    end,
  },
}
