return {
	"rest-nvim/rest.nvim",
	ft = "http",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"j-hui/fidget.nvim",
	},
	build = false, -- disable luarocks http install is treesitter job
	config = function()
		require("rest-nvim").setup({
			highlight = {
				enabled = true,
			},
			result = {
				show_headers = true,
				show_http_info = true,
			},
		})
	end,
}
