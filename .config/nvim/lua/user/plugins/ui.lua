return {
	{
		"startup-nvim/startup.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("startup").setup()
		end,
	},

	{
		"mhartington/formatter.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local util = require("formatter.util")
			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd

			augroup("__formatter__", { clear = true })

			autocmd("BufWritePost", {
				group = "__formatter__",
				command = "FormatWrite",
			})

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,

				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},

					javascript = {
						require("formatter.filetypes.javascript").prettier,
					},

					typescript = {
						require("formatter.filetypes.typescript").prettier,
					},

					python = {
						require("formatter.filetypes.python").black,
					},

					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})
		end,
	},

	-- Lualine (statusline)
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					icons_enabled = true,
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
				},

				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "diagnostics", "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = {
						function()
							return os.date("%H:%M")
						end,
					},
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},

	-- Status column with line numbers, folds, and signs
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			vim.opt.number = true
			vim.opt.relativenumber = true
			vim.opt.numberwidth = 4
			vim.opt.cursorline = true -- highlight current line

			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true, -- números relativos à direita

				segments = {
					-- fold column
					{ text = { builtin.foldfunc }, click = nil },

					-- diagnostic signs
					{
						sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
						click = nil,
					},

					-- line numbers
					{ text = { builtin.lnumfunc }, click = nil, colwidth = 2 },

					-- other signs (Git, LSP, etc.)
					{
						sign = { name = { ".*" }, maxwidth = 2, colwidth = 2, auto = true, wrap = true },
						click = nil,
					},
				},
			})
		end,
	},

	-- Barbecue - breadcrumbs
	-- not working fix later
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- here your config
			attach_navic = true, -- connect nvim-navic
			show_dirname = true,
			show_basename = true,
			theme = "auto",
		},
	},

	-- indentation GUIDES
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
}
