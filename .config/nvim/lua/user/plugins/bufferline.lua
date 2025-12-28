local function hl_to_hex(hl, key)
	if not hl or not hl[key] then
		return nil
	end
	return string.format("#%06x", hl[key])
end

local function get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
	if not ok then
		return {}
	end
	return hl
end

local function fg(name)
	return hl_to_hex(get_hl(name), "fg")
end

local function bg(name)
	return hl_to_hex(get_hl(name), "bg")
end

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
					bg = bg("Normal"),
				},

				-- inactive buffers
				background = {
					fg = fg("Comment") or fg("Normal"),
					bg = bg("Normal"),
				},

				-- active buffer
				buffer_selected = {
					fg = fg("Normal"),
					bg = bg("CursorLine") or bg("Normal"),
					bold = true,
				},

				-- separator
				separator = {
					fg = fg("Comment"),
					bg = bg("Normal"),
				},
				separator_selected = {
					fg = fg("DiagnosticInfo") or fg("Identifier"),
					bg = bg("Normal"),
				},

				-- indicator
				indicator_selected = {
					fg = fg("DiagnosticInfo") or fg("Identifier"),
				},
			},
		})

		vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
		vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
		vim.keymap.set("n", "<leader>b", ":bd<CR>", { silent = true })
	end,
}
