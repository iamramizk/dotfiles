return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
  opts = {
    notify = {
      enabled = false, -- This disables Noice's vim.notify override
    },
    presets = {
      lsp_doc_border = true,
      bottom_search = true,
    },
    cmdline = {
      enabled = true,
    },
  },
}
