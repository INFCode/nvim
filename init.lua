if vim.g.vscode then
    -- VSCode vim extension
else
    -- normal neovim config
    require("core")
    require("utils")
    require("diagnostic").setup()
    require("lazynvim")
    require("terminal").setup()
end
