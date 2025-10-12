local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
vim.keymap.set("n", "<leader>fF", builtin.find_files, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fW", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
require("oil").setup()
vim.keymap.set("n", "<leader>e", ":e .<CR>")

require("leap").create_default_mappings()
-- Define equivalence classes for brackets and quotes, in addition to
-- the default whitespace group.
require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
require("leap.user").set_repeat_keys("<enter>", "<backspace>")

local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.setup({})
