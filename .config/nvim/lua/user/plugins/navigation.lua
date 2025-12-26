return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				filesystem = {
					follow_current_file = true,
					use_libuv_file_watcher = true,
				},
				window = {
					position = "left",
					width = 30,
					mappings = {
						["l"] = "open",
						["h"] = "close_node",
						["<CR>"] = "open",
						["v"] = "open_vsplit",
						["s"] = "open_split",
					},
				},
				sources = { "filesystem", "buffers", "git_status" },
			})

			-- toggle  Neotree
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",

			{
				"ahmedkhalf/project.nvim",
				config = function()
					require("project_nvim").setup({
						detection_methods = { "pattern" },
						patterns = {
							".git",
							"package.json",
							"pyproject.toml",
							"Makefile",
						},
					})
				end,
			},
		},

		config = function()
			local has_telescope, telescope = pcall(require, "telescope")
			if not has_telescope then
				vim.notify("Telescope not found", vim.log.levels.WARN)
				return
			end

			telescope.setup({
				defaults = {
					prompt_prefix = "🔍 ",
					selection_caret = "❯ ",
					path_display = { "truncate" },
					layout_config = {
						horizontal = {
							preview_width = 0.55,
							results_width = 0.8,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_ignore_patterns = {
						"node_modules/",
						".git/",
						".DS_Store",
					},
				},
			})

			-- extensões
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "projects")

			-- keymaps
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "LSP definitions" })
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP references" })
		end,
	},
}
