-- restore the cursor position when opening a file
vim.api.nvim_create_augroup('RestoreCursor', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
    group = 'RestoreCursor',
    pattern = '*',
    callback = function()
        -- Cursor position before the last opening
        local last_pos = vim.fn.line("'\"")
        -- Total number of lines in the file
        local last_line = vim.fn.line("$")

        -- If the last cursor position is still valid
        if last_pos > 0 and last_pos <= last_line then
            -- Go there
            local col = vim.fn.col("'\"")
            vim.api.nvim_win_set_cursor(0, { last_pos, col - 1 })
        end
    end,
})

-- for python, force use the 'neovim' environment in pyenv
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = "*.py",
    callback = function()
        if vim.g.python3_host_prog then
            -- already set
            return
        end
        local neovim_python = vim.fn.system("pyenv prefix neovim"):gsub("\n", "") .. "/bin/python3"

        if vim.fn.executable(neovim_python) == 1 then
            vim.g.python3_host_prog = neovim_python
        else
            print("Warning: pyenv 'neovim' environment not found! Ensure it exists and has pynvim installed.")
        end
    end,
})
