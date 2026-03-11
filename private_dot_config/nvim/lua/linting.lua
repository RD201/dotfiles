-- Add export PATH=$HOME/.local/share/nvim/mason/bin:$PATH
-- to your bash/zshrc for linters installed with Mason to be found.

local lint = require("lint")
lint.linters_by_ft = {
	-- python = { "mypy", "ruff" },
	python = { "ruff" },
	-- python = { "flake8" },
	dockerfile = { "hadolint" },
	lua = { "luacheck" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

lint.linters.luacheck = {
	name = "lucheck",
	cmd = "luacheck",
	stdin = true,
	args = {
		"--globals",
		"vim",
	},
	stream = "stdout",
	ignore_exitcode = true,
	parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
		source = "luacheck",
	}),
}

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		require("lint").try_lint()
	end,
})
