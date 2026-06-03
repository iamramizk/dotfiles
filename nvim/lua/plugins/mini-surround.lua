return {
  "nvim-mini/mini.surround",
  -- "echasnovski/mini.surround",
  opts = {
    search_method = "cover_or_next",
    mappings = {
      add = "sa", -- Add surrounding in Normal and Visual modes
      delete = "sd", -- Delete surrounding
      replace = "sr", -- Replace surrounding
      -- find = "sf", -- Find surrounding (to the right)
      -- find_left = "sF", -- Find surrounding (to the left)
      -- highlight = "gsh", -- Highlight surrounding
      -- update_n_lines = "gsn", -- Update `n_lines`
    },
  },
}
