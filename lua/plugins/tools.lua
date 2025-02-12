return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        opts = {
            close_if_last_window = true,
            window = {
                mappings = {
                    ["P"] = {
                        "toggle_preview",
                        config = {
                            use_float = false,
                            -- use_image_nvim = true,
                            title = 'Preview',
                        },
                    },
                }
            }
        }

    },
    {
        "preservim/vim-pencil",
        init = function()
            vim.g["pencil#wrapModeDefault"] = "soft"
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    }
}
