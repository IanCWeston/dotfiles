return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 1000 * 1024 -- 1 MB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = true,
			},
			indent = {
				enable = true,
				disable = { "yaml", "python" },
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<M-n>",
					node_incremental = "<M-n>",
					scope_incremental = "<M-N>",
					node_decremental = "<M-p>",
				},
			},
			autopairs = {
				enable = true,
			},
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"dockerfile",
				"go",
				"vimdoc",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"vim",
				"yaml",
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]]"] = "@function.outer",
					},
					goto_next_end = {
						["]m"] = "@function.outer",
					},
					goto_previous_start = {
						["[["] = "@function.outer",
					},
					goto_previous_end = {
						["[m"] = "@function.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["]p"] = "@parameter.inner",
					},
					swap_previous = {
						["[p"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
	},
}
