vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
local diagnostic_group = vim.api.nvim_create_augroup("diagnostic", {})
vim.api.nvim_create_autocmd({"CursorHold","CursorHoldI"}, {
	pattern = "*",
	callback = function ()
		vim.diagnostic.open_float(nil, {focus=false})
	end,
	group = diagnostic_group
})
