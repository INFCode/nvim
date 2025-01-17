local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

function CustomizePalette()
	local palette = require("monokai").pro
	palette.grey = "#95917E"
	palette.base6 = "#95917E"
	return palette
end

require("lazy").setup({ -- lsp configs
	"neovim/nvim-lspconfig",
	-- nvim-cmp and its extensions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-calc",
	"hrsh7th/nvim-cmp",
	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		build = "make install_jsregexp",
		-- let LuaSnip be aware of friendly-snippets
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			-- luasnip load snippets
			require('luasnip.loaders.from_vscode').lazy_load()
		end
	},
	"saadparwaiz1/cmp_luasnip",
	"ray-x/cmp-treesitter",

	-- other plugins
	{
		"tanvirtin/monokai.nvim",
		opts = function()
			-- monokai color schieme
			return {
				palette = CustomizePalette(),
				italics = false
			}
		end
	},
	{
		"preservim/vim-pencil",
		config = function(_, opts)
			-- Define autocmd group for pencil
			local pencil_group = vim.api.nvim_create_augroup("pencil", {})

			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = "markdown,mkd",
			-- 	callback = function()
			-- 		require "pencil".init()
			-- 	end,
			-- 	group = pencil_group
			-- })
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = "text",
			-- 	callback = function()
			-- 		require "pencil".init()
			-- 	end,
			-- 	group = pencil_group
			-- })
		end
	},
	{
		"rhysd/accelerated-jk",
		config = function()
			-- Define accelerated_jk_acceleration_table
			vim.g.accelerated_jk_acceleration_table = { 4, 8, 16, 32 }
		end,
		keys = {
			{ "j", "<Plug>(accelerated_jk_gj)" },
			{ 'k', '<Plug>(accelerated_jk_gk)' }
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = function()
			local palette = CustomizePalette()
			-- TODO: replace these with vim.api.nvim_set_hl()
			vim.cmd("highlight IndentBlanklineIndent1 guifg=" .. palette.grey .. " gui=nocombine")
			vim.cmd("highlight IndentBlanklineIndent2 guifg=" .. palette.green .. " gui=nocombine")
			vim.cmd("highlight IndentBlanklineIndent3 guifg=" .. palette.aqua .. " gui=nocombine")
			vim.cmd("highlight IndentBlanklineIndent4 guifg=" .. palette.yellow .. " gui=nocombine")
			vim.cmd("highlight IndentBlanklineIndent5 guifg=" .. palette.purple .. " gui=nocombine")
			vim.cmd("highlight IndentBlanklineIndent6 guifg=" .. palette.red .. " gui=nocombine")

			return {
				indent = {
					highlight = {
						"IndentBlanklineIndent1",
						"IndentBlanklineIndent2",
						"IndentBlanklineIndent3",
						"IndentBlanklineIndent4",
						"IndentBlanklineIndent5",
						"IndentBlanklineIndent6",
					},
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
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua", "vim", "vimdoc", "cpp", "rust", "toml", "gitignore", "markdown",
				"markdown-inline" },
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		}
	}
})

-- load individual settings
require("lsp")
