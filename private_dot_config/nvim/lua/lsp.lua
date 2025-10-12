require("mason").setup()

-- Diagnostics
local config = {
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "single",
		source = "always",
		header = "",
		prefix = "",
		suffix = "",
	},
}
vim.diagnostic.config(config)

-- Lsp capabilities and on_attach
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
		if ok then
			diag.populate_workspace_diagnostics(client, bufnr)
		end
	end,
})

-- Disable the default keybinds {{{
for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
	pcall(vim.keymap.del, "n", bind)
end

-- Create keybindings, commands, inlay hints and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end
		---@diagnostic disable-next-line need-check-nil
		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
			-- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
		end
		---@diagnostic disable-next-line need-check-nil
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		--- Disable semantic tokens
		---@diagnostic disable-next-line need-check-nil
		client.server_capabilities.semanticTokensProvider = nil

		-- All the keymaps
		local keymap = vim.keymap.set
		local lsp = vim.lsp
		local opts = { silent = true }
		local function opt(desc, others)
			return vim.tbl_extend("force", opts, { desc = desc }, others or {})
		end
		keymap("n", "gd", lsp.buf.definition, opt("Go to definition"))
		keymap("n", "gi", function()
			lsp.buf.implementation({ border = "single" })
		end, opt("Go to implementation"))
		keymap("n", "gr", lsp.buf.references, opt("Show References"))
		keymap("n", "<C-k>", lsp.buf.signature_help, opts)
		-- disable the default binding first before using a custom one
		pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })
		keymap("n", "K", function()
			lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 })
		end, opt("Toggle hover"))
		keymap("n", "<Leader>ca", require("tiny-code-action").code_action, opt("Code Action"))
		keymap("n", "<Leader>lr", lsp.buf.rename, opt("Rename"))
		keymap("n", "<Leader>ls", lsp.buf.document_symbol, opt("Document Symbols"))

		-- diagnostic mappings
		keymap("n", "<Leader>dD", function()
			local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
			if ok then
				for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
					diag.populate_workspace_diagnostics(cur_client, 0)
				end
				vim.notify("INFO: Diagnostic populated")
			end
		end, opt("Popluate diagnostic for the whole workspace"))
		keymap("n", "<Leader>dn", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opt("Next Diagnostic"))
		keymap("n", "<Leader>dp", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opt("Prev Diagnostic"))
	end,
})

-- Lua
vim.lsp.config.gopls = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { ".git", "go.mod" },
	settings = {
		analyses = {
			unusedparams = true,
		},
		staticcheck = true,
		gofumpt = true,
	},
}
vim.lsp.enable("gopls")

vim.lsp.config.lua_ls = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".git" },
	settings = {
		gopls = {
			gofumpt = true,
		},
		Lua = {
			telemetry = {
				enable = false,
			},
		},
	},
}
vim.lsp.enable("lua_ls")

-- Python {{{
vim.lsp.config.basedpyright = {
	name = "basedpyright",
	filetypes = { "python" },
	cmd = { "basedpyright-langserver", "--stdio" },
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
			analysis = {
				autoSearchPaths = true,
				autoImportCompletions = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "recommended",
				inlayHints = {
					variableTypes = true,
					callArgumentNames = true,
					functionReturnTypes = true,
					genericTypes = false,
				},
			},
		},
	},
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		local ok, venv = pcall(require, "rj.extras.venv")
		if ok then
			venv.setup()
		end
		local root = vim.fs.root(0, {
			"poetry.lock",
			"pyproject.toml",
			"pyrightconfig.json",
			".git",
		})
		local client =
			vim.lsp.start(vim.tbl_extend("force", vim.lsp.config.basedpyright, { root_dir = root }), { attach = false })
		if client then
			vim.lsp.buf_attach_client(0, client)
		end
	end,
})

-- TSServer
vim.lsp.config.ts_ls = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

	root_dir = vim.fs.dirname(vim.fs.find({ "package.json", ".git" }, { upward = true })[1]),
	init_options = {
		hostInfo = "neovim",
	},
}
vim.lsp.enable("ts_ls")

-- SQL
vim.lsp.config.postgres_lsp = {
	cmd = { "postgrestools", "lsp-proxy" },
	filetypes = { "sql" },
	root_markers = { "postgrestools.jsoncs" },
}
vim.lsp.enable("postgres_lsp")
-- TerraformLS
vim.lsp.config.terraform_ls = {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform" },
	root_markers = { ".git" },
}
vim.lsp.enable("terraform_ls")

-- lsp logging
vim.api.nvim_create_user_command("LspLog", function()
	vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
	desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
	vim.cmd("silent checkhealth vim.lsp")
end, {
	desc = "Get all the information about all LSP attached",
})
