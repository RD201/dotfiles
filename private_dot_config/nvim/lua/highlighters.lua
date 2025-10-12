local set = vim.opt

set.hlsearch = false
set.incsearch = true

-- https://github.com/nvim-treesitter/nvim-treesitter
require("nvim-treesitter.configs").setup({
	modules = {},
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "go", "typescript" },
	sync_install = true,
	ignore_install = {},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
-- https://neovimcraft.com/plugin/rachartier/tiny-inline-diagnostic.nvim/
require("tiny-inline-diagnostic").setup({
	preset = "ghost",
	transparent_bg = false, -- Set the background of the diagnostic to transparent
	transparent_cursorline = false, -- Set the background of the cursorline to transparent (only one the first diagnostic)
	hi = {
		error = "DiagnosticError", -- Highlight group for error messages
		warn = "DiagnosticWarn", -- Highlight group for warning messages
		info = "DiagnosticInfo", -- Highlight group for informational messages
		hint = "DiagnosticHint", -- Highlight group for hint or suggestion messages
		arrow = "NonText", -- Highlight group for diagnostic arrows
		background = "CursorLine",
		mixing_color = "None",
	},
	options = {
		show_source = {
			enabled = true,
			if_many = true,
		},
		use_icons_from_diagnostic = false,
		set_arrow_to_diag_color = false,
		add_messages = true,
		throttle = 20,
		softwrap = 30,
		multilines = {
			enabled = false,
			always_show = false,
		},
		show_all_diags_on_cursorline = false,
		enable_on_insert = false,
		enable_on_select = false,
		overflow = {
			mode = "wrap",

			padding = 0,
		},
		break_line = {
			enabled = false,

			after = 30,
		},
		format = function(diagnostic)
			return diagnostic.message .. " [" .. diagnostic.source .. "]"
		end,
		virt_texts = {
			priority = 2048,
		},
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},
		overwrite_events = nil,
	},
	disabled_ft = {}, -- List of filetypes to disable the plugin
})
require("rainbow-delimiters.setup").setup({})
