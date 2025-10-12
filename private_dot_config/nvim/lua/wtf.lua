require("killersheep").setup({
	gore = true, -- Enables/disables blood and gore.
	keymaps = {
		move_left = "h", -- Keymap to move cannon to the left.
		move_right = "l", -- Keymap to move cannon to the right.
		shoot = "<Space>", -- Keymap to shoot the cannon.
	},
})

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
require("smear_cursor").setup({
	stiffness = 0.8,
	trailing_stiffness = 0.6,
	stiffness_insert_mode = 0.7,
	trailing_stiffness_insert_mode = 0.7,
	damping = 0.95,
	damping_insert_mode = 0.95,
	distance_stop_animating = 0.5,
})
