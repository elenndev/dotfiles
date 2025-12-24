return {
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
    if not ok then return end

    autotag.setup({})
  end,
}

