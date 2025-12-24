return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local ok, saga = pcall(require, "lspsaga")
    if not ok then return end

    saga.setup({
      server_filetype_map = {
        typescript = "typescript",
      },

      lightbulb = {
        enable = false,
      },
    })

    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
    vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
    vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
    vim.keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
    vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
  end,
}

