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

		-- Tree-sitter folding como padrão
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
		vim.opt.foldenable = true

		-- Rust usa indent folding (fallback)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "rust",
			callback = function()
				vim.opt_local.foldmethod = "indent"
			end,
		})
	end,
}
