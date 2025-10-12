return {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	"ibhagwan/fzf-lua",
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
	},
}
