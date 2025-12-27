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
				-- Opções globais de folding (OBRIGATÓRIAS pro ufo)
				vim.o.foldcolumn = "1"
				vim.o.foldlevel = 99
				vim.o.foldlevelstart = 99
				vim.o.foldenable = true

				-- Keymaps padrão do ufo
				vim.keymap.set("n", "zR", function()
					require("ufo").openAllFolds()
				end, { desc = "Open all folds" })

				vim.keymap.set("n", "zM", function()
					require("ufo").closeAllFolds()
				end, { desc = "Close all folds" })

				-- Setup do ufo (ESTRATÉGIA IDEAL)
				require("ufo").setup({
					provider_selector = function(bufnr, filetype, buftype)
						-- JSX / TSX / Rust: indent é o que funciona
						if filetype == "typescriptreact" or filetype == "javascriptreact" or filetype == "rust" then
							return { "indent" }
						end

						-- resto: treesitter primeiro, indent fallback
						return { "treesitter", "indent" }
					end,
				})
			end,
		},
	},
}
