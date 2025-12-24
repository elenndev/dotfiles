return {
    -- Mason
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason LSPConfig
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },

    -- LSPConfig
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("nvim-lspconfig")

            -- TypeScript / JavaScript
            lspconfig.ts_ls.setup({ capabilities = capabilities })

            -- ESLint
            lspconfig.eslint.setup({
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
                capabilities = capabilities,
            })

            -- Lua
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })

            -- HTML / CSS
            lspconfig.html.setup({ capabilities = capabilities })
            lspconfig.cssls.setup({ capabilities = capabilities })
        end,
    },
}

