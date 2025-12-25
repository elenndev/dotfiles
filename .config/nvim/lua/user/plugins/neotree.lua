return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                filesystem = {
                    follow_current_file = true,
                    use_libuv_file_watcher = true,
                },
                window = {
                    position = "left",
                    width = 30,
		    mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<CR>"] = "open",
        ["v"] = "open_vsplit",
        ["s"] = "open_split",
      },
                },
                sources = { "filesystem", "buffers", "git_status" },
            })

            -- toggle  Neotree 
            vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
        end,
    },
}

