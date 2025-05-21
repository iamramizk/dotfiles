-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Allow L/R to move U/D line at boundaries in n,v,i modes
vim.opt.whichwrap:append("<,>,[,]")

-- Enable line wrapping by default
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.sidescrolloff = 5

-- update icons
local icons = {
  Error = "",
  Warn = "",
  Info = "",
  Hint = "",
}
vim.diagnostic.config({
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.INFO] = icons.Info,
      [vim.diagnostic.severity.HINT] = icons.Hint,
    },
  },
  float = {
    border = "rounded",
  },
})

vim.g.lazy_picker = "snacks"

vim.g.lazyvim_python_lsp = "pyright"
