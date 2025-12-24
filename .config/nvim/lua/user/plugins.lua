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

  -- mason
 -- require("user.plugins.mason"),

  -- Treesitter
  require("user.plugins.treesitter"),
	require("user.plugins.autotag"),
	require("user.plugins.autopairs"),

  -- Toggleeterm
  require("user.plugins.toggleterm"),
  

  -- autocomplete.lua -> Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
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
require("user.plugins.lspsaga"),

  --  Neo-tree file explorer
  require("user.plugins.neotree"),

   -- telescope
  require("user.plugins.telescope"),

  -- Key binding helper
  require("user.plugins.whichkey"),
require("user.plugins.showkeys"),

-- tabs
require("user.plugins.bufferline"),

  -- visual stuff
  require("user.plugins.ui"),
require("user.plugins.themes"),

-- aquela amg performatica
require("user.plugins.presence"),

})

