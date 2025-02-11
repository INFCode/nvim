if vim.g.vscode then
	-- VSCode vim extension
else
	-- normal neovim config
	require("options")
	require("mappings")
	require("utils") -- this defines the _G.Utils, so it must go first
	require("diagnostic").setup()
	require("deps")
	require("autocmd")
	require("terminal").setup()
end
