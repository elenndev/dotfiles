-- Initialize core settings first
-- require('user.options')
-- require('user.keymaps')

-- config leader key
vim.g.mapleader = " " -- leader
vim.opt.clipboard = "unnamedplus"

-- Load plugin manager
require("user.options")
require("user.plugins")

-- Basic error handling wrapper for module loading
local function safe_require(module)
	local success, result = pcall(require, module)
	if not success then
		vim.notify("Error loading module '" .. module .. "': " .. result, vim.log.levels.ERROR)
		return nil
	end
	return result
end
