local spec = {
  {
    "savq/melange-nvim",
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme melange")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      vim.cmd("colorscheme github_dark_high_contrast")
    end,
  },
}

vim.keymap.set("n", "<leader>uu", function() --> Show all custom colors in telescope...
  for _, color in ipairs(spec) do --> Load all colors in spec....
    if color.name then
      vim.cmd("Lazy load " .. color.name)
    end
  end

  vim.schedule(function() --> Needs to be scheduled:
    -- stylua: ignore
    local builtins = { "melange", "github_dark_high_contrast" }

    local completion = vim.fn.getcompletion
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.fn.getcompletion = function() --> override
      return vim.tbl_filter(function(color)
        return not vim.tbl_contains(builtins, color) --
      end, completion("", "color"))
    end

    vim.cmd("Telescope colorscheme enable_preview=true")
    vim.fn.getcompletion = completion --> restore
  end)
end, { desc = "Telescope custom colors", silent = true })

return spec
