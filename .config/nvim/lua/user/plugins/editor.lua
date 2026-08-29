return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local ok, autopairs = pcall(require, "nvim-autopairs")
      if not ok then
        return
      end

      autopairs.setup({
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = {
      "html",
      "xml",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
    },
    config = function()
      local ok, autotag = pcall(require, "nvim-ts-autotag")
      if not ok then
        return
      end

      autotag.setup({})
    end,
  },
  {
    {
      "kevinhwang91/nvim-ufo",
      dependencies = {
        "kevinhwang91/promise-async",
      },
      event = "BufReadPost",
      config = function()
        -- global fold stuff
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- ufo default Keymaps
        vim.keymap.set("n", "zR", function()
          require("ufo").openAllFolds()
        end, { desc = "Open all folds" })

        vim.keymap.set("n", "zM", function()
          require("ufo").closeAllFolds()
        end, { desc = "Close all folds" })

        require("ufo").setup({
          provider_selector = function(bufnr, filetype, buftype)
            -- JSX / TSX / Rust: indent
            if filetype == "typescriptreact" or filetype == "javascriptreact" or filetype == "rust" then
              return { "indent" }
            end

            -- first treesitter, indent fallback
            return { "treesitter", "indent" }
          end,
        })
      end,
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      sign = {
        enabled = false,
      },
    },
  },
  -- {
  --   "github/copilot.vim",
  -- },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        format_on_save = function(bufnr)
          local max_filesize = 200 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
          if ok and stats and stats.size > max_filesize then
            return
          end

          return {
            timeout_ms = 3000,
            lsp_fallback = true,
            async = true,
          }
        end,

        formatters = {
          prettier = {
            command = "node_modules/.bin/prettier",
          },
        },

        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "eslint_d", "prettier" },
          javascriptreact = { "eslint_d", "prettier" },
          typescript = { "eslint_d", "prettier" },
          typescriptreact = { "eslint_d", "prettier" },
          python = { "black" },
          rust = { "rustfmt" },
        },
      })
    end,
  },
}
