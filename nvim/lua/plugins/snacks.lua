return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } }, -- Close picker on single Esc in normal and insert mode
          },
        },
      },
      layout = {
        preset = "ivy",
      },
    },
  },
}
