local function save_reload_and_restart_lsp()
  -- Save the current buffer
  vim.cmd('w')
  -- Reload the current buffer
  vim.cmd('e')
  -- Restart LSP
  vim.cmd('LspRestart')
  print("Buffer and LSP reloaded")
end
vim.api.nvim_create_user_command('SaveReloadAndRestartLsp', save_reload_and_restart_lsp, {})
