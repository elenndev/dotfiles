return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local ok, bufferline = pcall(require, "bufferline")
		if not ok then
			return
		end

		bufferline.setup({
			options = {
				mode = "buffers",
				separator_style = "slant",
				always_show_bufferline = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = true,
			},
			highlights = {
				separator = {
					guifg = "#30363d",
					guibg = "#0d1117",
				},
				separator_selected = {
					guifg = "#58a6ff",
					guibg = "#0d1117",
				},
				background = {
					guifg = "#8b949e",
					guibg = "#0d1117",
				},
				buffer_selected = {
					guifg = "#c9d1d9",
					guibg = "#161b22",
					gui = "bold",
				},
				fill = {
					guibg = "#0d1117",
				},
				modified = {
					fg = "#d29922",
				},
			},
		})

		vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
		vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
		vim.keymap.set("n", "<leader>b", ":bd<CR>", { silent = true })
	end,
}
