return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 50,
      open_mapping = [[<C-\>]],
      direction = "float",
      persist_size = true,
      start_in_insert = true,
    },

    -- customized terminals
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- custom terminals api
      local Terminal = require("toggleterm.terminal").Terminal

      local float_term = Terminal:new({
        direction = "float",
        size = 50,
        hidden = true,
        start_in_insert = true,
      })

      local vertical_term = Terminal:new({
        direction = "vertical",
        size = 40,
        hidden = true,
        start_in_insert = true,
      })

      local lazygit_float_term = Terminal:new({
        direction = "float",
        float_opts = {
          width = vim.o.columns,
          height = 100,
        },
        hidden = true,
        start_in_insert = true,
        cmd = "lazygit",
      })

      -- keymaps fo custom terminals
      vim.keymap.set("n", "<leader>tf", function()
        float_term:toggle()
      end, { desc = "Open float terminal" })

      vim.keymap.set("n", "<leader>tv", function()
        vertical_term:toggle()
      end, { desc = "Open vertical terminal" })

      -- custom terminal to lazygit
      vim.keymap.set("n", "<leader>tl", function()
        lazygit_float_term:toggle()
      end, { desc = "Open lazygit on float terminal" })

      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Quit Toggleterm terminal" })
    end,
  },
}
