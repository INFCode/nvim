return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"nui.nvim"
		},
		opts = {
			capabilities = {},
			codelens = {
				enable = true
			},
			inlay_hint = {
				enable = false
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							codeLens = {
								enable = true,
							},
							hint = {
								enable = false,
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

				local nui = require('nui.input')
				local event = require('nui.utils.autocmd').event

				-- create the window
				local function rename_symbol()
					local current_name = vim.fn.expand('<cword>')
					local params = vim.lsp.util.make_position_params()

					local input = nui({
						-- put the input box 1 row lower than current line
						relative = 'cursor',
						position = {
							row = 2,
							col = 0,
						},
						size = {
							width = 20,
							height = 1,
						},
						border = {
							style = "rounded",
							text = {
								top = "[Rename]",
								top_align = "center",
							},
						},
						win_options = {
							winhighlight = "Normal:Normal,FloatBoarder:SpecialChar",
						}
					}, {
						prompt = "> ",
						default_value = current_name,
						on_submit = function(new_name)
							if not new_name or #new_name == 0 or new_name == current_name then
								return
							end
							params.newName = new_name
							vim.lsp.buf.rename(new_name, nil)
							vim.notify("Renamed " .. current_name .. " to " .. new_name)
						end,
					})

					-- enable the input window
					input:mount()

					-- close when the cursor leaves or press esc in normal mode
					input:on(event.BufLeave, input.input_props.on_close, { once = true })
					input:map("n", "<esc>", input.input_props.on_close, { noremap = true })
				end

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
				setmap('n', '<leader>rn', rename_symbol, opts)
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
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(env)
					-- key mappings
					opts.keymap(env)

					-- format on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = env.buf,
						callback = function()
							vim.lsp.buf.format { async = false, id = env.data.client_id }
						end,
					})
				end
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

			local on_attach = function(client, bufnr)
				-- inlay hint
				if opts.inlay_hint.enable and client.supports_method("textDocument/inlayHint", { bufnr = bufnr }) then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
				-- code lens
				if opts.codelens.enable and client.supports_method("textDocument/codeLens", { bufnr = bufnr }) then
					vim.lsp.codelens.refresh({ bufnr = bufnr })
					vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
						buffer = bufnr,
						callback = function()
							vim.lsp.codelens.refresh({ bufnr = bufnr })
						end,
					})
				end
			end

			local function setup(server)
				require("lspconfig")[server].setup({
					settings = servers[server].settings or {},
					capabilities = capabilities,
					on_attach = on_attach
				})
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
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
