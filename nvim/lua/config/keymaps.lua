-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lua/config/keymaps.lua
local opts = { noremap = true, silent = true }

-- DUPLICATE CURRENT LINE
vim.keymap.set("n", "<S-D>", ":t.<CR>", opts)

-- REDO
vim.keymap.set("n", "<S-U>", ":redo<CR>", opts)

-- Move cursor by wrapped lines in insert mode
vim.keymap.set("i", "<Up>", "<C-o>gk", opts)
vim.keymap.set("i", "<Down>", "<C-o>gj", opts)

-- Map ' to blackhole register to avoid overwriting default register
vim.keymap.set("n", "'", '"_', opts)

-- PAGE UP REMAP
vim.keymap.set("n", "<C-e>", "<C-u>", opts)

-- Delete line before cursor with command + backspace
vim.keymap.set("i", "<D-BS>", "<Esc>v0d$a", opts)

-- YANK FULL FILE PATH TO CLIPBOARD
vim.keymap.set(
  "n",
  "<leader>fy",
  ":let @+=expand('%:p')<CR>",
  { noremap = true, silent = true, desc = "Yank file path" }
)

-- SAVE, RELOAD, AND RESTART LSP
vim.keymap.set(
  { "n", "v" },
  "<leader>R",
  ":SaveReloadAndRestartLsp<CR>",
  { noremap = true, silent = true, desc = "Save & Reload" }
)

-- REPLACE FILE WITH CLIPBOARD
vim.keymap.set(
  { "n", "v" },
  "<leader>fR",
  ":ReplaceFileWithClipboard<CR>",
  { noremap = true, silent = true, desc = "Replace file with Clip" }
)

-- TROUBLE DIAGNOSTICS MAPPING
vim.keymap.set(
  { "n", "v" },
  "T",
  ":Trouble diagnostics toggle filter.buf=0<CR>",
  { noremap = true, silent = true, desc = "Trouble Diagnostics" }
)

-- SNACKS BUFFERS
vim.keymap.set("n", "<leader>,", function()
  Snacks.picker.buffers({ sort_lastused = false })
end, { noremap = true, silent = true, desc = "Buffers" })

vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.buffers({ sort_lastused = false })
end, { noremap = true, silent = true, desc = "Buffers" })

-- SNACKS LIVE GREP
vim.keymap.set("n", "//", function()
  Snacks.picker.lines({
    layout = { preview = false },
  })
end, { noremap = true, silent = true, desc = "Live Grep Current Buffer" })

-- SNACKS FIND HIDDEN FILES
vim.keymap.set("n", "<leader>fh", function()
  -- Snacks.picker.files({ hidden = true })
  Snacks.picker.files({
    layout = {
      layout = {
        backdrop = false,
        row = 1,
        width = 0.4,
        min_width = 80,
        height = 0.4,
        border = "none",
        box = "vertical",
        { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
        { win = "list", border = "rounded" },
      },
    },
  })
end, { noremap = true, silent = true, desc = "Find Hidden Files" })

-- NEOMINIMAP TOGGLE
vim.keymap.set("n", "|", "<cmd>Neominimap toggle<cr>", { noremap = true, silent = true, desc = "Toggle minimap" })
vim.keymap.set(
  "n",
  "<leader>um",
  "<cmd>Neominimap toggle<cr>",
  { noremap = true, silent = true, desc = "Toggle minimap" }
)
