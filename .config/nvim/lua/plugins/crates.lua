return {
  "saecki/crates.nvim",
  tag = "v0.3.0",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function(_, opts)
    require("crates").setup(opts)
  end,
}
