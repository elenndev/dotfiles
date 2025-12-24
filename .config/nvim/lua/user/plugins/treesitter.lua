return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  priority = 100,
  config = function()
    local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      return
    end

    ts_configs.setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "javascript", "typescript", "python",
        "rust", "html", "css", "json", "yaml", "toml",
        "markdown", "bash"
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
  end,
}

