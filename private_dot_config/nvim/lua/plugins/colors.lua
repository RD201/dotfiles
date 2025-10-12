return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}
