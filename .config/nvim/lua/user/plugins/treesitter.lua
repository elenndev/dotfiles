return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	priority = 100,
	config = function()
		local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
		if not ok then
			return
		end

		ts_configs.setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"python",
				"rust",
				"html",
				"css",
				"json",
				"yaml",
				"toml",
				"markdown",
				"bash",
			},
			auto_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
				},
			},
		})

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			callback = function(args)
				local bufnr = args.buf
				local lang = vim.api.nvim_buf_get_option(bufnr, "filetype")
				if lang and vim.treesitter.highlighter.active[bufnr] then
					vim.api.nvim_buf_set_option(bufnr, "foldmethod", "expr")
					vim.api.nvim_buf_set_option(bufnr, "foldexpr", "nvim_treesitter#foldexpr()")
					vim.api.nvim_buf_set_option(bufnr, "foldlevel", 99)
					vim.api.nvim_buf_set_option(bufnr, "foldlevelstart", 99)
					vim.api.nvim_buf_set_option(bufnr, "foldenable", true)
				end
				if lang == "rust" then
					vim.opt_global.foldmethod = "expr"
					vim.opt_global.foldexpr = "nvim_treesitter#foldexpr()"
					vim.opt_local.foldenable = true
				end
			end,
		})
	end,
}
