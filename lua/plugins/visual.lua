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
			local lighten = require("monokai-pro.color_helper").lighten

			local function get_fg_color(hl_group)
				local hl = vim.api.nvim_get_hl(0, { name = hl_group })

				if hl and hl.fg then
					return string.format("#%06x", hl.fg)
				else
					return "NONE"
				end
			end

			local hl_monokai = {}
			local hl_light_monokai = {}
			local monokai_hl_group_prefix = "IndentBlankLineIndent"
			local light_hl_group_prefix = "IndentBlankLineScope"
			for i = 1, 6 do
				local indent_color_group = monokai_hl_group_prefix .. i
				local scope_color_group = light_hl_group_prefix .. i
				table.insert(hl_monokai, indent_color_group)
				local hex = get_fg_color(indent_color_group)
				local lighten_hex = lighten(hex, 60)
				vim.api.nvim_set_hl(0, scope_color_group, { fg = lighten_hex })
				table.insert(hl_light_monokai, scope_color_group)
			end


			return {
				indent = {
					highlight = hl_monokai,
					char = "▏",
					smart_indent_cap = true,
				},
				scope = {
					highlight = hl_light_monokai,
					char = '▎',
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
	},
	{
		'echasnovski/mini.icons',
		version = false,
	},
}
