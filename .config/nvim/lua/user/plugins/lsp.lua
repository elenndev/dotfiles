local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if ok then
	capabilities = cmp_lsp.default_capabilities(capabilities)
end

local function on_attach(_, bufnr)
	local opts = { buffer = bufnr, silent = true }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			-- Mason
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"pyright",
					"dockerls",
					"clangd",
					"bashls",
					"eslint",
				},

				automatic_enable = {
					exclude = {
						"rust_analyzer",
					},
				},
			})

			-- Capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

			if ok then
				capabilities = cmp_lsp.default_capabilities(capabilities)
			end

			-- Keymaps on attach
			local function on_attach(_, bufnr)
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				-- code actions
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end

			-- C
			require("lspconfig").clangd.setup({})

			-- LUA
			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
				on_attach = on_attach,

				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},

						diagnostics = {
							globals = { "vim" },
						},

						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},

						telemetry = {
							enable = false,
						},
					},
				},
			}

			-- BASH
			vim.lsp.config.bashls = {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "sh", "bash", "zsh" },
			}

			-- TYPESCRIPT
			vim.lsp.config.ts_ls = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			-- ESLINT
			vim.lsp.config.eslint = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			-- PYTHON
			vim.lsp.config.pyright = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			-- RUST
			-- vim.lsp.config.rust_analyzer = {
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- }

			-- DOCKER
			vim.lsp.config.dockerls = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			-- C/C++
			vim.lsp.config.clangd = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	callback = function(args)
			-- 		local server = vim.lsp.config[vim.bo[args.buf].filetype]
			--
			-- 		if server then
			-- 			vim.lsp.start(server)
			-- 		end
			-- 	end,
			-- })

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("bashls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("pyright")
			vim.lsp.enable("dockerls")
			vim.lsp.enable("clangd")
			vim.lsp.enable("eslint")

			-- Diagnostics UI
			vim.diagnostic.config({
				virtual_text = true,
				float = {
					border = "rounded",
				},
				signs = true,
			})
		end,
	},

	{
		"nvimdev/lspsaga.nvim",

		event = "LspAttach",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			local ok, saga = pcall(require, "lspsaga")

			if not ok then
				return
			end

			saga.setup({
				server_filetype_map = {
					typescript = "typescript",
				},

				lightbulb = {
					enable = false,
				},
			})

			local opts = {
				noremap = true,
				silent = true,
			}

			vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)

			vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)

			vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)

			vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)

			vim.keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)

			vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
		end,
	},

	{

		{
			"mrcjkb/rustaceanvim",
			version = "^6",
			ft = { "rust" },
			opts = {
				server = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
			},
		},
	},
}
