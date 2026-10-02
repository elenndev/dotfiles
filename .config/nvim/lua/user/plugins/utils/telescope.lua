local M = {}

function M.find_files()
  local cwd = vim.fn.getcwd()
  local dotfiles_path = vim.fn.expand("~/dotfiles")

  local is_dotfiles = cwd == dotfiles_path

  require("telescope.builtin").find_files({
    cwd = cwd,
    hidden = is_dotfiles,
    no_ignore = is_dotfiles,
  })
end

return M
