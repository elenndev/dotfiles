local function get_local()
  local ok, cfg = pcall(require, "user.local_config")
  if ok and type(cfg) == "table" and cfg.colorscheme then
    return cfg
  end
  return nil
end

local local_cfg = get_local()

local specs = {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      if not local_cfg then
        require("github-theme").setup({})
        vim.cmd("colorscheme github_dark_high_contrast")
      end
    end,
  },
}

if local_cfg and local_cfg.plugin then
  table.insert(specs, local_cfg.plugin)
end

if local_cfg then
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    once = true,
    callback = function()
      local_cfg.setup()
    end,
  })
end

return specs
