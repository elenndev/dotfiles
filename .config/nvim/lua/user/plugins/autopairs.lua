return {
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
}

