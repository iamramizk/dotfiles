-- THEME
lvim.transparent_window = true
lvim.icons.ui.Circle = " ●"
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "catppuccin-macchiato"

-- remove telescope bg
lvim.autocommands = {
  {
    { "ColorScheme" },
    {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
      end,
    },
  },
}


-- Minimap
vim.api.nvim_create_autocmd("BufEnter", {
  command = "highlight minimapCursor guibg=#1a2331 guifg=#ffffff"
})
vim.api.nvim_create_autocmd("BufEnter", {
  command = "highlight minimapRange guibg=#0f0e1f guifg=#acacac"
})
