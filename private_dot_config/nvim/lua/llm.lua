require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "scaleway",
			model = "devstral-small-2505",
		},
	},
	opts = {
		log_level = "DEBUG",
	},
})
