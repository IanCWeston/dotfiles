local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
    --  LUA
		formatting.stylua,

    --  PYTHON
		formatting.isort,
		formatting.black,
		-- diagnostics.flake8,

    --  SHELL
    formatting.shfmt,
    formatting.shellharden,
    -- diagnostics.shellcheck,

    -- JSON/YAML/MARKDOWN
		formatting.prettier,

    -- YAML
    -- diagnostics.yamllint,
    -- diagnostics.ansiblelint,
	},
})
