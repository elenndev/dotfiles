return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 50,
			open_mapping = [[<C-\>]],
			direction = "float",
			persist_size = true,
			start_in_insert = true,
		},

		-- customized terminals
		config = function(_, opts)
			require("toggleterm").setup(opts)

			-- custom terminals api
			local Terminal = require("toggleterm.terminal").Terminal

			local vertical_term = Terminal:new({
				direction = "vertical",
				size = 40,
				hidden = false,
				start_in_insert = true,
			})

			local horizontal_term = Terminal:new({
				direction = "horizontal",
				hidden = false,
				start_in_insert = true,
			})

			local lazygit_float_term = Terminal:new({
				direction = "float",
				float_opts = {
					width = vim.o.columns,
					height = 100,
				},
				hidden = false,
				start_in_insert = true,
				cmd = "lazygit",
			})

			-- keymaps fo custom terminals
			vim.keymap.set("n", "<leader>th", function()
				horizontal_term:toggle()
			end, { desc = "Open horizontal terminal" })

			vim.keymap.set("n", "<leader>tv", function()
				vertical_term:toggle()
			end, { desc = "Open vertical terminal" })

			-- custom terminal to lazygit
			vim.keymap.set("n", "<leader>tl", function()
				lazygit_float_term:toggle()
			end, { desc = "Open lazygit on float terminal" })

			vim.keymap.set("t", "<leader>tn", [[<C-\><C-n>]], { desc = "Go to Normal mode" })
		end,
	},
}
