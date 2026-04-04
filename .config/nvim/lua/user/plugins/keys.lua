return {
	{
		"nvzone/showkeys",
		event = "VeryLazy",
		config = function()
			require("showkeys").setup({
				timeout = 1,
				maxkeys = 4,
				show_count = false,
			})

			vim.defer_fn(function()
				vim.cmd("ShowkeysToggle")
			end, 100)
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local ok, which_key = pcall(require, "which-key")
			if not ok then
				return
			end

			which_key.setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = { enabled = false },
				},
				win = { border = "rounded" },
			})

			which_key.register({
				["<leader>b"] = { name = "Buffer" },
				["<leader>bd"] = { "<cmd>bdelete<cr>", "Delete buffer" },
				["<leader>bn"] = { "<cmd>bnext<cr>", "Next buffer" },
				["<leader>bp"] = { "<cmd>bprevious<cr>", "Prev buffer" },

				["<leader>e"] = { "<cmd>Neotree toggle<cr>", "Explorer" },

				["<leader>f"] = { name = "File" },
				["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
				["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
				["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
				["<leader>fn"] = { "<cmd>enew<cr>", "New file" },
				["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent" },

				["<leader>l"] = { name = "LSP" },
				["<leader>lR"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
				["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
				["<leader>ld"] = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
				["<leader>lf"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
				["<leader>lh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
				["<leader>lr"] = { "<cmd>Telescope lsp_references<cr>", "References" },
			})
		end,
	},
}
