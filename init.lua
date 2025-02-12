if vim.g.vscode then
    -- VSCode vim extension
else
    -- normal neovim config
    require("options")
    require("mappings")
    require("utils")
    require("diagnostic").setup()
    require("deps")
    require("autocmd")
    require("terminal").setup()
end
