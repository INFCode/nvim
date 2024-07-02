local M = {}

function M.set_float_autocmd()
	vim.o.updatetime = 250
	local group = vim.api.nvim_create_augroup("diagnostic", {})
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		pattern = "*",
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			}
			vim.diagnostic.open_float(opts, { focus = false })
		end,
		group = group
	})
end

function M.setup()
	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		signs = true,
		float = {
			border = 'rounded',
			source = 'if_many',
		},
	})

	M.set_float_autocmd()
end

return M
