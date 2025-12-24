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
                },
                sources = { "filesystem", "buffers", "git_status" },
            })

            -- Keymap para abrir/fechar o Neo-tree
            vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
        end,
    },
}

