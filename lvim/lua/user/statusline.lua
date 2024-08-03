local function current_path()
  local path = vim.fn.expand('%:p:h')
  local parent = vim.fn.fnamemodify(path, ':h:t')
  local current = vim.fn.fnamemodify(path, ':t')
  return " " .. string.format("%s", current)
end

lvim.builtin.lualine.sections.lualine_b = {
  {
    current_path,
    color = {
      fg = "#6399FE"
    },
  },
  {
    "b:gitsigns_head",
    color = {
      gui = "bold"
    },
    icon = "%#SLGitIcon#%*%#SLBranchName#"
  },
}
