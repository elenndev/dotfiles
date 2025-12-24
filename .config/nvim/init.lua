-- Initialize core settings first
-- require('user.options')
-- require('user.keymaps')

-- config leader key
vim.g.mapleader = " "  -- leader = espaço
vim.opt.clipboard = "unnamedplus"


-- Load plugin manager
require('user.plugins')

-- Set up plugins with dependencies
-- require('user.treesitter') -- Set up before LSP for better highlighting
-- require('user.lsp')  -- Depends on language servers being available
-- Configure UI components last
-- require('user.theme')
-- require('user.statusline')

-- Basic error handling wrapper for module loading
local function safe_require(module)
  local success, result = pcall(require, module)
  if not success then
    vim.notify("Error loading module '" .. module .. "': " .. result, vim.log.levels.ERROR)
    return nil
  end
  return result
end

-- Then use it for loading modules
-- local treesitter = safe_require("user.plugins.treesitter")

-- require("mason").setup()


