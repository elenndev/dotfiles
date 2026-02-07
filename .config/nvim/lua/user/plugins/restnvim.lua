return {
	"rest-nvim/rest.nvim",
	ft = "http",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"j-hui/fidget.nvim",
		"nvim-telescope/telescope.nvim",
	},
	build = false, -- disable luarocks http install is treesitter job
	config = function()
		require("rest-nvim").setup({
			root = vim.fn.expand("~/scripts-http/"),
			highlight = {
				enabled = true,
			},
			result = {
				show_headers = true,
				show_http_info = true,
			},
		})

		pcall(function()
			require("telescope").load_extension("rest")
		end)
	end,
}
