return {
  -- Lualine (statusline)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
        },

        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "diagnostics", "encoding", "filetype" },
          lualine_y = { "progress" },
          lualine_z = {
            function()
              return os.date("%H:%M")
            end,
          },
        },

        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },

  -- Line numbers
  -- {
    -- "shrynx/line-numbers.nvim",
    -- opts = {}, 
  -- },

  -- status col
  {
  "luukvbaal/statuscol.nvim",
  config = function()
    vim.opt.number = true
    vim.opt.relativenumber = true
    -- highlight cursor line
    vim.opt.cursorline = true
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true, -- números relativos à direita

      segments = {
        -- fold column
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },

        -- diagnostic signs
        {
          sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
          click = "v:lua.ScSa",
        },

        -- line numbers
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },

        -- other signs (Git, LSP, etc.)
        {
          sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}

}

