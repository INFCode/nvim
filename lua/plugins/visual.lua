return {
	{
		"loctvl842/monokai-pro.nvim",
		opts = {
			filter = "spectrum",
			background_clear = {
				"float_win"
			}
		},
		config = function(_, opts)
			require("monokai-pro").setup(opts)
			vim.cmd([[colorscheme monokai-pro]])
		end,
		priority = 1000
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = function()
			local palette = require("monokai-pro.colorscheme").base

			local color_map = {
				-- rainbow indent
				{ hl_group = "IblIndent1", color = palette.dark },
				{ hl_group = "IblIndent2", color = palette.green },
				{ hl_group = "IblIndent3", color = palette.cyan },
				{ hl_group = "IblIndent4", color = palette.magenta },
				{ hl_group = "IblIndent5", color = palette.blue },
				{ hl_group = "IblIndent6", color = palette.red },
				-- scope color
				{ hl_group = "IblScope",   color = palette.yellow },
			}

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				for _, group in ipairs(color_map) do
					vim.api.nvim_set_hl(0, group.hl_group, { fg = group.color })
				end
			end)

			local hl_groups = {}
			for _, group in pairs(color_map) do
				if vim.startswith(group.hl_group, "IblIndent") then
					table.insert(hl_groups, group.hl_group)
				end
			end

			return {
				indent = {
					highlight = hl_groups,
					char = "▏",
					smart_indent_cap = true,
				}
			}
		end
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "virtualtext", -- Set the display mode.
				virtualtext = "■",
			},
		},
	},
	{
		"MunifTanjim/nui.nvim"
	}
}
