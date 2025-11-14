vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.wo.diff then
      vim.cmd("highlight DiffAdd guibg=#3a3 guifg=#000")
      vim.cmd("highlight DiffChange guibg=#ff3 guifg=#000")
      vim.cmd("highlight DiffDelete guibg=#f33 guifg=#fff")
      vim.cmd("highlight DiffText guibg=#38f guifg=#fff")
    end
  end,
})

return {}
