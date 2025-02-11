-- key mapping
local map = vim.keymap.set
vim.g.mapleader = "'"

map("i", "jk", "<esc>")
map("n", "<leader>h", "<cmd>nohl<cr>")
