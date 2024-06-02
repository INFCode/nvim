return {
	{
		"hrsh7th/nvim-cmp",
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
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'snippets' },
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
	}
}
