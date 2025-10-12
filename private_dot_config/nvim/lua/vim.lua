-- Set line numbers
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Enable true color support
vim.opt.termguicolors = true

-- Enable mouse support
vim.opt.mouse = 'a'

-- Set tab and indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable line wrapping
vim.opt.wrap = true

-- Show matching brackets and parenthesis
vim.opt.showmatch = true

-- Incremental search
vim.opt.incsearch = true

-- Ignore case while searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable clipboard integration
vim.opt.clipboard = 'unnamedplus'

-- Set split windows to open below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set status line
vim.opt.laststatus = 2

-- Disable backup and swap files
vim.opt.backup = false
vim.opt.swapfile = false

-- Auto-save undo history
vim.opt.undofile = true

