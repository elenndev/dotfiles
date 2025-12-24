return {
  "nvzone/showkeys",
  event = "VeryLazy",
  config = function()
    require("showkeys").setup({
      timeout = 1,      -- always show
      maxkeys = 4,      -- show last key
      show_count = false,
    })

  vim.cmd("ShowkeysToggle")
  end,
}

