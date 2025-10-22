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
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NeominimapCursorLine", { bg = "#202537" })
  vim.api.nvim_set_hl(0, "NeominimapSearchSign", { fg = "#6EA3FE" })
  vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#2B2E43", bg = "#00D8BD" })
  vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#BDCAF9", bg = "#3358A3" })

  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#2C334D" })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#2C334D" })
  vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#6271A6" })

  -- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#16161E" })
  vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none", italic = true })
end

-- Apply on ColorScheme event
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_custom_highlights,
})

-- Apply highlights on startup (in case colorscheme already loaded, ie when opening from dashboard)
set_custom_highlights()

-- Auto indent before saving py files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    -- Save the current window view (cursor position + scroll)
    local view = vim.fn.winsaveview()
    vim.cmd("normal! gg=G") -- Re-indent the entire buffer
    vim.lsp.buf.format({ async = false }) -- Call LSP format synchronously
    vim.fn.winrestview(view) -- Restore the window view (cursor position and scroll)
  end,
  desc = "Auto re-indent and format Python on save",
})

-- -- Auto enable minimap based on width
-- local function toggle_minimap_by_width()
--   if vim.o.columns > 100 then
--     vim.cmd("Neominimap on")
--   else
--     vim.cmd("Neominimap off")
--   end
-- end
--
-- -- Run once on VimEnter (startup)
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = toggle_minimap_by_width,
-- })
--
-- -- Run on every window resize
-- vim.api.nvim_create_autocmd("VimResized", {
--   callback = toggle_minimap_by_width,
-- })
