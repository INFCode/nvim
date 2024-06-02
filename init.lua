-- Options
local set = vim.opt

-- display
set.number = true
set.relativenumber = true
set.cursorline = true

-- search
set.hlsearch = true
set.incsearch = true
set.showmatch = true

-- edit
set.autoindent = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.virtualedit = "block"

-- cursor movement
set.whichwrap = 'b,s,h,l,[,]'
set.scrolloff = 3

-- display
set.wrap = false

-- split windows
set.splitright = true

-- clipboard
vim.opt.clipboard:append({"unnamedplus"})

-- key mapping
local map = vim.keymap.set
vim.g.mapleader = "'"

map("i", "jk", "<esc>")
map("n", "<leader>h", "<cmd>nohl<cr>")

if vim.loop.os_uname().sysname == "Linux" then
    vim.opt.clipboard:append({"unnamedplus"})
end

if vim.g.vscode then
    -- VSCode vim extension
else
    -- normal neovim config
    require("deps")
end
