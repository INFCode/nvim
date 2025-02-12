-- key mapping
local map = vim.keymap.set

-- leader key
vim.g.mapleader = "'"
vim.g.maplocalleader = "'"

local default_opts = { noremap = true, silent = true } -- default options for the mappings
map("i", "jk", "<esc>", default_opts)                  -- Use `jk` to exit insert mode
map("n", "<leader>h", "<cmd>nohl<cr>", default_opts)   -- use leader-h to stop highlighing
map("n", "x", '"_x', default_opts)                     -- delete single character without polluting the register

-- Moving between tabs
map('n', '<Tab>', ':bnext<CR>', default_opts)
map('n', '<S-Tab>', ':bprevious<CR>', default_opts)

-- Window management
map('n', '<leader>v', '<C-w>v', default_opts) -- split window vertically
map('n', '<leader>h', '<C-w>s', default_opts) -- split window horizontally

-- Resize splits with Ctrl-arrows
map('n', '<C-Up>', ':resize -2<CR>', default_opts)
map('n', '<C-Down>', ':resize +2<CR>', default_opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', default_opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', default_opts)
