return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          before_init = function(_, config)
            local venv = vim.fn.getcwd() .. "/.venv"
            if vim.fn.isdirectory(venv) == 1 then
              config.settings.python.pythonPath = venv .. "/bin/python"
            end
          end,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
      },
    },
  },
}
