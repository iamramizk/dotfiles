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

local function replace_file_with_clipboard()
  -- Clear the current buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
  -- Paste the clipboard contents
  vim.cmd('normal! "+p')
  -- Save the file
  vim.cmd('w')
  print("File contents replaced with clipboard")
end
vim.api.nvim_create_user_command('ReplaceFileWithClipboard', replace_file_with_clipboard, {})
