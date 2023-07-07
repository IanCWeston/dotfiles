return {
  -- Base
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    lazy = true,
    config = function()
      require("lsp-zero.settings").preset({})
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lua" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      { "bammab/vscode-snippets-for-ansible" },
    },
    config = function()
      require("lsp-zero.cmp").extend()

      local cmp = require("cmp")
      local cmp_action = require("lsp-zero.cmp").action()

      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_confirm = { behavior = cmp.SelectBehavior.Insert, select = true }

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        mapping = {
          ["<Tab>"] = vim.NIL,
          ["<S-Tab>"] = vim.NIL,
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<CR>"] = cmp.mapping.confirm(cmp_confirm),

          -- Snippets
          ["<C-j>"] = cmp_action.luasnip_jump_forward(),
          ["<C-k>"] = cmp_action.luasnip_jump_backward(),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind_icons = require("ian.util.icons").kind
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "williamboman/mason.nvim" },
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp = require("lsp-zero")

      local servers = {
        "lua_ls", -- formally sumneko_lua
        "bashls",
        "yamlls",
        "ansiblels",
        "pyright",
        "jsonls",
        "dockerls",
        -- 'gopls',
        -- 'terraformls',
      }

      lsp.on_attach(function(client, bufnr)
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
      end)

      -- We use null-ls for formatting
      lsp.set_server_config({
        capabilities = {
          documentFormattingProvider = false,
          documentFormattingRangeProvider = false,
        },
      })

      -- Configure lua language server for neovim
      require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

      lsp.configure("pyright", {
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

      lsp.configure("yamlls", {
        yaml = {
          schemaStore = {
            enable = true,
          },
        },
      })

      lsp.set_sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
      }

      lsp.setup()

      vim.diagnostic.config({
        virtual_text = true,
      })
    end,
  },

  -- Extra Formatting and Linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_opts = require("lsp-zero").build_options("null-ls", {})
      local null_ls = require("null-ls")
      local diagnostics = null_ls.builtins.diagnostics
      local formatting = null_ls.builtins.formatting

      null_ls.setup({
        on_attach = function(client, bufnr)
          null_opts.on_attach(client, bufnr)
        end,
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

  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {},
  },
}
