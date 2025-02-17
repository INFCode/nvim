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
            local current_cursor = vim.api.nvim_win_get_cursor(0)
            local success, value = pcall(vim.api.nvim_win_get_var, 0, "diagnostics_last_cursor_pos")
            local last_popup_cursor = success and value or { nil, nil }

            -- Show the popup diagnostics window,
            -- but only once for the current cursor location (unless moved afterwards).
            if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
                vim.api.nvim_win_set_var(0, "diagnostics_last_cursor_pos", current_cursor)
                local opts = {
                    focusable = false,
                    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                }
                vim.diagnostic.open_float(opts, { focus = false })
            end
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
