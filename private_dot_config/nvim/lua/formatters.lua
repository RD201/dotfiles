require("conform").setup({
	formatters_by_ft = {
		json = { "prettier" },
		lua = { "stylua" },
		-- python = { "isort", "black" },
		python = { "isort", "ruff_format" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		javascript = { "prettier" },
		go = { "gofumpt", "golines" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 5000,
	},
})
