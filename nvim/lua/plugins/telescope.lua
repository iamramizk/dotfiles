return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<Esc>"] = require("telescope.actions").close, -- single <Esc> closes Telescope immediately in insert mode
        },
      },
    },
    pickers = {
      find_files = {
        theme = "ivy",
      },
      live_grep = {
        theme = "ivy",
      },
      git_files = {
        theme = "ivy",
      },
      buffers = {
        theme = "ivy",
      },
    },
  },
}
