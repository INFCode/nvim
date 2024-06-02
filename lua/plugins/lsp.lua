return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			capabilities = {},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { 'vim' }
							}
						}
					}
				},
				jsonls = {
				},
				rust_analyzer = {
					settings = {
						['rust-analyzer'] = {},
					},
				}
			},
			keymap = function(ev)
				local opts = { buffer = ev.buf }
				local setmap = vim.keymap.set
				setmap('n', 'gD', vim.lsp.buf.declaration, opts)
				setmap('n', 'gd', vim.lsp.buf.definition, opts)
				setmap('n', 'K', vim.lsp.buf.hover, opts)
				setmap('n', 'gi', vim.lsp.buf.implementation, opts)
				setmap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				setmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
				setmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
				setmap('n', '<leader>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				setmap('n', '<leader>D', vim.lsp.buf.type_definition, opts)
				setmap('n', '<leader>rn', vim.lsp.buf.rename, opts)
				setmap({ 'n', 'v' }, '<leader>aw', vim.lsp.buf.code_action, opts)
				setmap('n', 'gr', vim.lsp.buf.references, opts)
				setmap('n', '<leader>F', function()
					vim.lsp.buf.format { async = true }
				end, opts)
				setmap('n', '<leader>fc', function()
					vim.lsp.buf.code_action({
						filter = function(a) return a.isPreferred end,
						apply = true
					})
				end, opts)
			end,
		},
		config = function(_, opts)
			-- key mappings
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = opts.keymap
			})
			-- load all servers
			local servers = opts.servers

			local have_cmp, cmp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				have_cmp and cmp.default_capabilities() or {},
				opts.capabilities or {}
			)

			local have_mlsp, mlsp = pcall(require, "mason-lspconfig")
			local all_mlsp_servers = {}
			if have_mlsp then
				all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local function setup(server)
				require("lspconfig")[server].setup({ settings = servers[server], capabilities = capabilities })
			end

			local ensure_installed = {}
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason is not true or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason ~= true or not vim.tbl_contains(all_mlsp_servers, server) then
						setup(server)
					elseif server_opts.enabled ~= false then
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mlsp then
				mlsp.setup({
					ensure_installed = ensure_installed,
					handlers = { setup },
				})
			end
		end
	},
	{
		"williamboman/mason.nvim",
	}
}
