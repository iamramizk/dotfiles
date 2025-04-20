-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Allow left/right arrow keys to move to previous/next line when at line boundaries
vim.opt.whichwrap:append("<,>")

-- Enable line wrapping by default
vim.opt.wrap = true
vim.opt.linebreak = true

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
})

vim.g.lazy_picker = "snacks"

vim.g.lazyvim_python_lsp = "pyright"
