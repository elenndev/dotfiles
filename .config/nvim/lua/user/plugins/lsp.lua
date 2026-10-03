local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },

    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "ts_ls", "pyright", "dockerls",
          "clangd", "bashls", "eslint",
        },
        automatic_enable = {
          exclude = { "rust_analyzer" },
        },
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- global keymaps using LspAttach to all servers
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })

      -- Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Bash
      vim.lsp.config("bashls", {
        capabilities = capabilities,
        filetypes = { "sh", "bash", "zsh" },
      })

      -- TypeScript
      vim.lsp.config("ts_ls", { capabilities = capabilities })

      -- ESLint
      vim.lsp.config("eslint", { capabilities = capabilities })

      -- Python
      vim.lsp.config("pyright", { capabilities = capabilities })

      -- Docker
      vim.lsp.config("dockerls", { capabilities = capabilities })

      -- C / C++  ← AQUI o ajuste importante
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })

      vim.lsp.enable({
        "lua_ls", "bashls", "ts_ls", "pyright",
        "dockerls", "clangd", "eslint",
      })

      vim.diagnostic.config({
        virtual_text = true,
        float = { border = "rounded" },
        signs = true,
      })
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local ok, saga = pcall(require, "lspsaga")
      if not ok then return end

      saga.setup({
        server_filetype_map = { typescript = "typescript" },
        lightbulb = { enable = false },
        symbol_in_winbar = {
          enable = false,
        },
      })

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
      vim.keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
      vim.keymap.set("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
      vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
      -- Não sobrescreva gd/K se já definiu no LspAttach
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    -- Sem on_attach/capabilities aqui — o plugin cuida disso
    opts = {},
  },
}
