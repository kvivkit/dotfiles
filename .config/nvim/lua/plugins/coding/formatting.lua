return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports"},
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				json = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				markdown = { "prettierd" },
			},
      formatters = {
        ruff_format = {
          command = "uv",
          prepend_args = { "run", "ruff", "format", "--stdin-filename", "$FILENAME", "-" },
        },
      },
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
