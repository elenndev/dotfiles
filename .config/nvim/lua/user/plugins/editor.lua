return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local ok, autopairs = pcall(require, "nvim-autopairs")
			if not ok then
				return
			end

			autopairs.setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = {
			"html",
			"xml",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
		},
		config = function()
			local ok, autotag = pcall(require, "nvim-ts-autotag")
			if not ok then
				return
			end

			autotag.setup({})
		end,
	},
	{
		{
			"kevinhwang91/nvim-ufo",
			dependencies = {
				"kevinhwang91/promise-async",
			},
			event = "BufReadPost",
			config = function()
				-- global fold stuff
				vim.o.foldcolumn = "1"
				vim.o.foldlevel = 99
				vim.o.foldlevelstart = 99
				vim.o.foldenable = true

				-- ufo default Keymaps
				vim.keymap.set("n", "zR", function()
					require("ufo").openAllFolds()
				end, { desc = "Open all folds" })

				vim.keymap.set("n", "zM", function()
					require("ufo").closeAllFolds()
				end, { desc = "Close all folds" })

				require("ufo").setup({
					provider_selector = function(bufnr, filetype, buftype)
						-- JSX / TSX / Rust: indent
						if filetype == "typescriptreact" or filetype == "javascriptreact" or filetype == "rust" then
							return { "indent" }
						end

						-- first treesitter, indent fallback
						return { "treesitter", "indent" }
					end,
				})
			end,
		},
	},
	{
		"mhartington/formatter.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local util = require("formatter.util")
			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd

			augroup("__formatter__", { clear = true })

			autocmd("BufWritePost", {
				group = "__formatter__",
				command = "FormatWrite",
			})

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,

				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},

					javascript = {
						require("formatter.filetypes.javascript").prettier,
					},

					javascriptreact = {
						require("formatter.filetypes.javascript").prettier,
					},

					typescript = {
						require("formatter.filetypes.typescript").prettier,
					},

					typescriptreact = {
						require("formatter.filetypes.typescript").prettier,
					},

					python = {
						require("formatter.filetypes.python").black,
					},

					rust = {
						require("formatter.filetypes.rust").rustfmt,
					},

					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			sign = {
				enabled = false,
			},
		},
	},
	{
		"github/copilot.vim",
	},
}
