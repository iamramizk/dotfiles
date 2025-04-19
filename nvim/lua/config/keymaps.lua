-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lua/config/keymaps.lua
local opts = { noremap = true, silent = true }

-- Duplicate current line with Shift+D
vim.keymap.set("n", "<S-D>", ":t.<CR>", opts)

-- Redo with Shift+U
vim.keymap.set("n", "<S-U>", ":redo<CR>", opts)

-- Map ' to blackhole register to avoid overwriting default register
vim.keymap.set("n", "'", '"_', opts)

vim.keymap.set("n", "//", LazyVim.pick("grep_buffers"))

-- Map 'fy' in normal mode to yank full file path to clipboard
vim.keymap.set(
  "n",
  "<leader>fy",
  ":let @+=expand('%:p')<CR>",
  { noremap = true, silent = true, desc = "Yank file path" }
)

-- mapping for custom script to save, reload, and restart lsp
vim.keymap.set(
  { "n", "v" },
  "<leader>R",
  ":SaveReloadAndRestartLsp<CR>",
  { noremap = true, silent = true, desc = "Save & Reload" }
)

-- replace file with clipboard
vim.keymap.set(
  { "n", "v" },
  "<leader>fR",
  ":ReplaceFileWithClipboard<CR>",
  { noremap = true, silent = true, desc = "Replace file with Clip" }
)

-- trouble diagnostics mapping
vim.keymap.set(
  { "n", "v" },
  "T",
  ":Trouble diagnostics toggle filter.buf=0<CR>",
  { noremap = true, silent = true, desc = "Trouble Diagnostics" }
)
