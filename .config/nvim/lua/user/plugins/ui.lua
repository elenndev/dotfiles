return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"⠀⠀⠀⠀⢀⠠⠤⠀⢀⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠐⠀⠐⠀⠀⢀⣾⣿⡇⠀⠀⠀⠀⠀⢀⣼⡇⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⠀⠀⠀⠀⣴⣿⣿⠇⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣇⠀⠀⢀⣾⣿⣿⣿⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠐⠀⡀",
				"⠀⠀⠀⠀⢰⡿⠉⠀⡜⣿⣿⣿⡿⠿⢿⣿⣿⡃⠀⠀⠂⠄⠀",
				"⠀⠀⠒⠒⠸⣿⣄⡘⣃⣿⣿⡟⢰⠃⠀⢹⣿⡇⠀⠀⠀⠀⠀",
				"⠀⠀⠚⠉⠀⠊⠻⣿⣿⣿⣿⣿⣮⣤⣤⣿⡟⠁⠘⠠⠁⠀⠀",
				"⠀⠀⠀⠀⠀⠠⠀⠀⠈⠙⠛⠛⠛⠛⠛⠁⠀⠒⠤⠀⠀⠀⠀",
				"⠨⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠀⠀⠀⠀⠀⠀",
				"⠁⠃⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			}

			dashboard.section.buttons.val = {
				dashboard.button("p", "  Projects", ":Telescope projects<CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
				dashboard.button("r", "󰄉  Recent", ":Telescope oldfiles<CR>"),
				dashboard.button(
					"c",
					"  Config",
					":cd " .. vim.fn.stdpath("config") .. " | Telescope find_files<CR>"
				),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}

			dashboard.section.footer.val = {
				"...",
			}

			alpha.setup(dashboard.config)
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

	{
		"luukvbaal/statuscol.nvim",
		config = function()
			require("statuscol").setup({
				relculright = true,
			})
		end,
	},

	-- Status column with line numbers, folds, and signs
	-- {
	-- 	"luukvbaal/statuscol.nvim",
	-- 	config = function()
	-- 		vim.opt.number = true
	-- 		vim.opt.relativenumber = true
	-- 		vim.opt.numberwidth = 4
	-- 		vim.opt.cursorline = true -- highlight current line
	--
	-- 		local builtin = require("statuscol.builtin")
	-- 		require("statuscol").setup({
	-- 			relculright = true, -- números relativos à direita
	--
	-- 			segments = {
	-- 				-- fold column
	-- 				{ text = { builtin.foldfunc }, click = nil },
	--
	-- 				-- diagnostic signs
	-- 				{
	-- 					sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
	-- 					click = nil,
	-- 				},
	--
	-- 				-- line numbers
	-- 				{ text = { builtin.lnumfunc }, click = nil, colwidth = 2 },
	--
	-- 				-- other signs (Git, LSP, ...)
	-- 				{
	-- 					sign = { name = { ".*" }, maxwidth = 2, colwidth = 2, auto = true, wrap = true },
	-- 					click = nil,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- Barbecue - breadcrumbs
	-- not working fix later
	-- {
	-- 	"utilyre/barbecue.nvim",
	-- 	name = "barbecue",
	-- 	version = "*",
	-- 	dependencies = {
	-- 		"SmiteshP/nvim-navic",
	-- 		"nvim-tree/nvim-web-devicons", -- optional dependency
	-- 	},
	-- 	opts = {
	-- 		-- here your config
	-- 		attach_navic = true, -- connect nvim-navic
	-- 		show_dirname = true,
	-- 		show_basename = true,
	-- 		theme = "auto",
	-- 	},
	-- },

	-- indentation GUIDES
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	vim.api.nvim_set_hl(0, "StatusColSeparator", {
		fg = "#44475a",
	}),

	vim.api.nvim_set_hl(0, "StatusColLineNr", {
		fg = "#6272a4",
	}),

	vim.api.nvim_set_hl(0, "StatusColGitSignsAdd", {
		fg = "#7ad87a",
	}),
}
