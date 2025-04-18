-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
    vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "DropBar", { bg = "none" })
    vim.api.nvim_set_hl(0, "DropBarFileName", { bg = "none", fg = "#FFFFFF" })
    vim.api.nvim_set_hl(0, "DropBarFileNameModified", { fg = "#FF9856" })
    vim.api.nvim_set_hl(0, "DropBarMenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { bg = "none" })
    -- Dim the symbols after file name (breadcrumbs)

    local breadcrumb_fg = "#54608C"
    local breadcrumb_opts = { fg = breadcrumb_fg, italic = true }
    vim.api.nvim_set_hl(0, "DropBarBreadcrumb", breadcrumb_opts)
  end,
})
