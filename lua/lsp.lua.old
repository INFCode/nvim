-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup language servers.
local lspconfig = require('lspconfig')

lspconfig.pyright.setup {
	capabilities = capabilities
}

lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
		},
	},
	capabilities = capabilities
}

lspconfig.rust_analyzer.setup {
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		['rust-analyzer'] = {},
	},
	capabilities = capabilities
}

lspconfig.ccls.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>aw', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>F', function()
			vim.lsp.buf.format { async = true }
		end, opts)
		-- quick fix
		vim.keymap.set('n', '<leader>fc', function()
			vim.lsp.buf.code_action({
				filter = function(a) return a.isPreferred end,
				apply = true
			})
		end, opts)
	end,
})

-- Set up nvim-cmp.
local cmp = require('cmp')
local luasnip = require('luasnip')

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

cmp.setup({
	snippet = {
		expand = function(args)
			-- use luasnip to expand snippets
			luasnip.lsp_expand(args.body)
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
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-f>'] = cmp.mapping(function(fallback)
			if cmp.visible_docs then
				cmp.mapping.scroll_docs(4)
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-CR>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		-- jumpting in snippets
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'treesitter' },
		{ name = 'path',    keyword_length = 1 },
		{ name = 'calc' },
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
