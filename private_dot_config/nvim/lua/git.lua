require("gitblame").setup({
	enabled = false,
})
vim.keymap.set("n", "<leader>gl", ":GitBlameToggle<CR>", {})
vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", {})
