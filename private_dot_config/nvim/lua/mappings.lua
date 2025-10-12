local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Paste without overwriting register
keymap("v", "<leader>p", '"_dP', opts)

-- Save with Ctrl+s
keymap("n", "<C-s>", ":w<CR>", opts) -- Normal mode
keymap("i", "<C-s>", "<Esc>:w<CR>", opts) -- Insert mode
keymap("v", "<C-s>", "<Esc>:w<CR>gv", opts) -- Visual mode

-- Close buffer with leader+q
keymap("n", "<leader>q", ":Bdelete<CR>", opts)

-- Navigate splits
keymap("n", "<leader>h", "<C-w>h", opts) -- Move left
keymap("n", "<leader>l", "<C-w>l", opts) -- Move right
keymap("n", "<leader>j", "<C-w>j", opts) -- Move down
keymap("n", "<leader>k", "<C-w>k", opts) -- Move up

-- Navigate buffer
keymap("n", "[b", ":bprev<CR>", opts) -- Move up
keymap("n", "]b", ":bnext<CR>", opts) -- Move up
