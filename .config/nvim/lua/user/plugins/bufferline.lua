local function get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
	if not ok then
		return {}
	end
	return hl
end

local Normal = get_hl("Normal")
local Comment = get_hl("Comment")
local CursorLine = get_hl("CursorLine")
local Identifier = get_hl("Identifier")
local DiagnosticInfo = get_hl("DiagnosticInfo")

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
				fill = {
					bg = Normal.bg,
				},

				-- inactive buffers
				background = {
					fg = Comment.fg or Normal.fg,
					bg = Normal.bg,
				},

				-- active buffers
				buffer_selected = {
					fg = Normal.fg,
					bold = true,
				},

				-- separator
				separator = {
					fg = Comment.fg,
					bg = Normal.bg,
				},
				separator_selected = {
					fg = DiagnosticInfo.fg or Identifier.fg,
					bg = Normal.bg,
				},
			},
		})

		vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
		vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
		vim.keymap.set("n", "<leader>b", ":bd<CR>", { silent = true })
	end,
}
