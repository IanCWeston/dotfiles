return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    local mappings = {
      { "<leader>/", "<cmd>norm gcc<cr>", desc = "Comment", nowait = true, remap = false },
      {
        "<leader><space>",
        function()
          Snacks.picker.buffers({ layout = { preset = "select" } })
        end,
        desc = "Buffers",
        nowait = true,
        remap = false,
      },
      {
        "<leader>F",
        function()
          Snacks.picker.grep({ layout = { preset = "ivy" } })
        end,
        desc = "Find Text",
        nowait = true,
        remap = false,
      },
      { "<leader>L", "<cmd>Lazy<CR>", desc = "Lazy", nowait = true, remap = false },
      { "<leader>c", "<cmd>bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
      { "<leader>e", "<cmd>Oil<CR>", desc = "Explore Filesystem", nowait = true, remap = false },
      {
        "<leader>f",
        function()
          Snacks.picker.files({ layout = { preset = "select" } })
        end,
        desc = "Find files",
        nowait = true,
        remap = false,
      },
      { "<leader>g", group = "Git", nowait = true, remap = false },
      {
        "<leader>gR",
        "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
        desc = "Reset Buffer",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Checkout branch",
        nowait = true,
        remap = false,
      },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
      { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
      { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
      { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
      { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
      {
        "<leader>gp",
        "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
        desc = "Preview Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gr",
        "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
        desc = "Reset Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gs",
        "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
        desc = "Toggle Stage Hunk",
        nowait = true,
        remap = false,
      },
      { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
      { "<leader>l", group = "LSP", nowait = true, remap = false },
      { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
      {
        "<leader>lS",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Workspace Symbols",
        nowait = true,
        remap = false,
      },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
      {
        "<leader>ld",
        "<cmd>Telescope lsp_document_diagnostics<cr>",
        desc = "Document Diagnostics",
        nowait = true,
        remap = false,
      },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
      {
        "<leader>lj",
        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
        desc = "Next Diagnostic",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lk",
        "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
        desc = "Prev Diagnostic",
        nowait = true,
        remap = false,
      },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
      {
        "<leader>lq",
        "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
        desc = "Quickfix",
        nowait = true,
        remap = false,
      },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
      {
        "<leader>ls",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Document Symbols",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Trouble Diagnostics",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lw",
        "<cmd>Telescope lsp_workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics",
        nowait = true,
        remap = false,
      },
      { "<leader>p", '"+p', desc = "System Paste", nowait = true, remap = false },
      { "<leader>q", "<cmd>q<CR>", desc = "Quit", nowait = true, remap = false },
      { "<leader>s", group = "Search", nowait = true, remap = false },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
      { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
      { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
      { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
      { "<leader>w", "<cmd>w<CR>", desc = "Save", nowait = true, remap = false },
      { "<leader>y", '"+y', desc = "System Yank", nowait = true, remap = false },
    }

    local vmappings = {
      { "<leader>/", "gc", desc = "Comment", mode = "v", nowait = true, remap = true },
      { "<leader>y", '"+y', desc = "System Yank", mode = "v", nowait = true, remap = false },
    }

    wk.add(mappings)
    wk.add(vmappings)
  end,
}
-- TODO: Move keymaps to individual plugins
