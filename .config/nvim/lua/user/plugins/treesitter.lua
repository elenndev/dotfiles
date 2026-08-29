return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  lazy = false,
  priority = 100,

  config = function()
    local ts_configs = require("nvim-treesitter.configs")

    ts_configs.setup({
      ensure_installed = {
        "lua",
        "http",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "rust",
        "html",
        "css",
        "json",
        "yaml",
        "toml",
        "markdown",
        "bash",
      },

      auto_install = false,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },

      incremental_selection = {
        enable = true,

        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
        },
      },
    })

    -- Fix for LSP hover bug
    -- block #set-lang-from-info-string! from query markdown query
    vim.treesitter.query.set("markdown", "injections", [[
      (fenced_code_block
        (info_string
          (language) @injection.language)
        (code_fence_content) @injection.content)

      ((html_block) @injection.content
        (#set! injection.language "html")
        (#set! injection.combined)
        (#set! injection.include-children))

      ((minus_metadata) @injection.content
        (#set! injection.language "yaml")
        (#offset! @injection.content 1 0 -1 0)
        (#set! injection.include-children))

      ((plus_metadata) @injection.content
        (#set! injection.language "toml")
        (#offset! @injection.content 1 0 -1 0)
        (#set! injection.include-children))

      ([
        (inline)
        (pipe_table_cell)
      ] @injection.content
        (#set! injection.language "markdown_inline"))
    ]])
  end,
}
