-- plugins.lua
-- Bootstrap Lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	print("Installing lazy.nvim...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
	print("Lazy.nvim installed!")
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
return require("lazy").setup({
	-- Essential plugins
	"nvim-lua/plenary.nvim",

	-- Treesitter
	require("user.plugins.treesitter"),

	-- editor utils -> auto tags and pairs
	require("user.plugins.editor"),

	-- Toggleeterm
	require("user.plugins.toggleterm"),

	-- autocomplete.lua -> Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("user.plugins.autocomplete")
		end,
	},

	-- lsp
	require("user.plugins.lsp"),

	-- navigation -> neotree, telescope, projects
	require("user.plugins.navigation"),

	-- http
	require("user.plugins.kulala"),

	-- Key binding helper and show
	require("user.plugins.keys"),

	-- tabs
	require("user.plugins.bufferline"),

	-- visual stuff
	require("user.plugins.ui"),
	require("user.plugins.themes"),

	-- aquela amg performatica
	require("user.plugins.presence"),

	-- git
	require("user.plugins.git"),

	-- debug
	require("user.plugins.debug"),
})
