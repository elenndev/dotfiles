return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_config = { width = 0.9, height = 0.9 },
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar arquivos" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar texto no projeto" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buscar buffers" })
    end,
  },
}
