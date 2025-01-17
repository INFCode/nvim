local M = {}

function M.set_float_autocmd()
	-- This specifies how long nvim will wait for new inputs before writing
	-- swap file to the disk, and also the wait time before CursorHold being
	-- triggered.
	-- The default updatetime is 4000, which is too long to wait for the diagnostic
	-- :h CursorHold says in the future there might be a separate config for the
	-- wait time, so we won't need to mess up with the swap files.
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
