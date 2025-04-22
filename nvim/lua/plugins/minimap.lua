return {
  "Isrothy/neominimap.nvim",
  version = "v3.x.x",
  lazy = false,
  init = function()
    -- vim.opt.wrap = false
    -- vim.opt.sidescrolloff = 36
    vim.g.neominimap = {
      auto_enable = true,
      exclude_filetypes = {
        "help",
        "bigfile",
      },
      exclude_buftypes = {
        "nofile",
        "nowrite",
        "quickfix",
        "terminal",
        "prompt",
      },
      float = {
        minimap_width = 10,
        window_border = "none",
      },
      x_multiplier = 5,
      y_multiplier = 2,
      diagnostic = {
        enabled = false,
      },
      search = {
        enabled = true,
        mode = "sign",
      },
      git = {
        enabled = false,
      },
      delay = 100,
    }
  end,
}
