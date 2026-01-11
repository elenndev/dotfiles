return {
	{
		"nvzone/showkeys",
		event = "VeryLazy",
		config = function()
			require("showkeys").setup({
				timeout = 1, -- always show
				maxkeys = 4, -- show last key
				show_count = false,
			})

			vim.defer_fn(function()
				vim.cmd("ShowkeysToggle")
			end, 100)
		end,
	},

	{
		"folke/which-key.nvim",
		lazy = false,
		config = function()
			local ok, which_key = pcall(require, "which-key")
			if not ok then
				return
			end

			which_key.setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = { enabled = true, suggestions = 20 },
					presets = {
						operators = true,
						motions = true,
						text_objects = true,
						windows = true,
						nav = true,
						z = true,
						g = true,
					},
				},
				layout = { height = { min = 4, max = 25 }, width = { min = 20, max = 50 } },
				win = { border = "rounded", padding = { 2, 2, 2, 2 } },
			})

			local mappings = {
				{ "<leader>b", group = "Buffer" },
				{ "<leader>bd", desc = "<cmd>bdelete<cr>" },
				{ "<leader>bn", desc = "<cmd>bnext<cr>" },
				{ "<leader>bp", desc = "<cmd>bprevious<cr>" },

				{ "<leader>e", desc = "<cmd>Neotree toggle<cr>" },

				{ "<leader>f", group = "File" },
				{ "<leader>fb", desc = "<cmd>Telescope buffers<cr>" },
				{ "<leader>ff", desc = "<cmd>Telescope find_files<cr>" },
				{ "<leader>fg", desc = "<cmd>Telescope live_grep<cr>" },
				{ "<leader>fn", desc = "<cmd>enew<cr>" },
				{ "<leader>fr", desc = "<cmd>Telescope oldfiles<cr>" },

				{ "<leader>l", group = "LSP" },
				{ "<leader>lR", desc = "<cmd>lua vim.lsp.buf.rename()<cr>" },
				{ "<leader>la", desc = "<cmd>lua vim.lsp.buf.code_action()<cr>" },
				{ "<leader>ld", desc = "<cmd>Telescope lsp_definitions<cr>" },
				{ "<leader>lf", desc = "<cmd>lua vim.lsp.buf.format()<cr>" },
				{ "<leader>lh", desc = "<cmd>lua vim.lsp.buf.hover()<cr>" },
				{ "<leader>lr", desc = "<cmd>Telescope lsp_references<cr>" },
			}

			which_key.register(mappings)
		end,
	},
}
