return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- existing release is too old and lack of bug fix
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			{
				"garymjr/nvim-snippets",
				opts = {
					friendly_snippets = true,
				},
				dependencies = { "rafamadriz/friendly-snippets" },
			}
		},
		opts = function()
			local cmp = require("cmp")
			-- LuaJIT still uses unpack
			local has_words_before = function()
				local row, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]:sub(col, col):match("%s") == nil
			end
			return {
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping(function(fallback)
						if cmp.visible_docs() then
							cmp.mapping.scroll_docs(-4)
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<C-f>'] = cmp.mapping(function(fallback)
						if cmp.visible_docs then
							cmp.mapping.scroll_docs(4)
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<C-CR>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm(),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						elseif vim.snippet.active({ direction = 1 }) then
							vim.snippet.jump(1)
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }
					),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if vim.snippets.active({ direction = -1 }) then
							vim.snippet.jump(-1)
						elseif cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end
					)
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'snippets' , max_item_count = 5},
					{ name = 'lazydev', group_index = 0},
					--{ name = 'treesitter' },
					{ name = 'path',    keyword_length = 1 },
					{ name = 'calc' },
				}, {
					{ name = 'buffer' },
				}),
				experimental = {
					ghost_text = true,
				}
			}
		end
	},
	{
		"zbirenbaum/copilot.lua",
		opts = {
			filetypes = {
				markdown = true,
				help = true,
			},
		}
	}
}
