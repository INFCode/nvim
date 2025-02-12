local M = {}

local WezTerm = {}

WezTerm.set_user_var = function(key, value)
    -- only handles value of the following types: nil, boolean, number, string and table
    local function serialize(value)
        local ty = type(value)
        if ty == "nil" then
            value = ""
        elseif ty == "boolean" or ty == "number" then
            value = tostring(value)
        elseif ty == "string" then
            value = value
        elseif ty == "table" then
            value = vim.json.encode(value)
        else
            error("Cannot serialize value of type " .. ty .. " for WezTerm user variable")
        end
        return value
    end
    local encoded_value = vim.base64.encode(serialize(value))

    local user_var_template = "\x1b]1337;SetUserVar=%s=%s\a"
    local cmd = user_var_template:format(key, encoded_value)
    -- print(("sending wezterm user variable, cmd = %s"):format(cmd))
    vim.api.nvim_chan_send(vim.v.stderr, cmd)
end

-- When using Wezterm, let it know vim entering and leaving
WezTerm.autocmd_vim_status = function()
    local autocmd = vim.api.nvim_create_autocmd

    autocmd({ "VimEnter", "VimResume" }, {
        callback = function()
            WezTerm.set_user_var("NVIM_ACTIVE", true)
        end,
    })

    autocmd({ "VimLeave", "VimSuspend" }, {
        callback = function()
            WezTerm.set_user_var("NVIM_ACTIVE", false)
        end,
    })
end

M.WezTerm = WezTerm

M.setup = function()
    -- print("Terminal setup")
    if vim.env.TERM_PROGRAM == "WezTerm" then
        -- print("running in wezterm")
        M.WezTerm.autocmd_vim_status()
    end
end

return M
