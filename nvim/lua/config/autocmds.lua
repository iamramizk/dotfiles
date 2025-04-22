-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     local dim_fg = "#54608C"
--     vim.api.nvim_set_hl(0, "WinBar", { fg = dim_fg, bg = "none" })
--     vim.api.nvim_set_hl(0, "WinBarNC", { fg = dim_fg, bg = "none" })
--     vim.api.nvim_set_hl(0, "NavicText", { fg = dim_fg })
--     vim.api.nvim_set_hl(0, "NavicSeparator", { fg = dim_fg })
--     vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#13151D" })
--   end,
-- })
local function set_custom_highlights()
  local dim_fg = "#54608C"
  vim.api.nvim_set_hl(0, "WinBar", { fg = dim_fg, bg = "none" })
  vim.api.nvim_set_hl(0, "WinBarNC", { fg = dim_fg, bg = "none" })
  vim.api.nvim_set_hl(0, "NavicText", { fg = dim_fg })
  vim.api.nvim_set_hl(0, "NavicSeparator", { fg = dim_fg })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#22273C" })
end

-- Apply on ColorScheme event
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_custom_highlights,
})

-- Apply highlights on startup (in case colorscheme already loaded, ie when opening from dashboard)
set_custom_highlights()
