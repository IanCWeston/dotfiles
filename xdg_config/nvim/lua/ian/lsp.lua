local lsp = require("lsp-zero")

local cmp = require('cmp')
local luasnip = require('luasnip')
local null_ls = require('null-ls')

lsp.preset({
    name = 'minimal',
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = false,
})

local servers = {
    'lua_ls', -- formally sumneko_lua
    'bashls',
    'yamlls',
    'ansiblels',
    'pyright',
    'jsonls',
    'dockerls',
    -- 'gopls',
    -- 'terraformls',
}

lsp.ensure_installed(servers)
lsp.nvim_workspace() -- auto setup lua_ls/sumneko_lua

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_confirm = { behavior = cmp.SelectBehavior.Insert, select = true }

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
        ['<Tab>'] = vim.NIL,
        ['<S-Tab>'] = vim.NIL,
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ['<CR>'] = cmp.mapping.confirm(cmp_confirm),

        -- Snippets
        ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind_icons = require('ian.icons').kind
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

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gS", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<M-a>", function() vim.lsp.buf.code_action() end, opts)

    -- We use null-ls for formatting
    for _, server in ipairs(servers) do
        if client.name == server then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentFormattingRangeProvider = false
        end
    end
end)

lsp.configure('pyright', {
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

lsp.configure('yamlls', {
    yaml = {
        schemaStore = {
            enable = true
        }
    }
})


lsp.setup()

-- NULL-LS
local null_opts = lsp.build_options('null-ls', {})
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)
    end,
    sources = {
        formatting.prettier.with {
            extra_filetypes = { "toml" },
            extra_args = { "--no-semi", "--single-quote" },
        },
        formatting.isort,
        formatting.black.with { extra_args = { "--fast" } },
        formatting.stylua,
        diagnostics.shellcheck,
    }
})

-- Trying this out
vim.diagnostic.config({
    virtual_text = true,
})
