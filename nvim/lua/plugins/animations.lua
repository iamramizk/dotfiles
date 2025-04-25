return {
  {
    "sphamba/smear-cursor.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      cursor_color = "#7B7E89",
      smear_between_buffers = true,
      animation_timing = "ease_out",

      smear_between_neighbor_lines = true,
      min_horizontal_distance_smear = 30,
      min_vertical_distance_smear = 2,

      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,

      -- faster   - default [range]
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.4      [0, 1]
      stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      distance_stop_animating = 0.9, -- 0.1      > 0
    },
  },
  {
    "echasnovski/mini.animate",
    enabled = true,
    opts = function(_, opts)
      opts.scroll = opts.scroll or {}
      opts.scroll.timing = opts.scroll.timing
        or require("mini.animate").gen_timing.ease_out({ duration = 80, unit = "total" })

      -- opts.cursor = opts.cursor or {}
      -- opts.cursor.timing = opts.cursor.timing
      --   or require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" })

      -- Disable specific animations
      return vim.tbl_deep_extend("force", opts, {
        resize = { enable = false },
        open = { enable = false },
        close = { enable = false },
        cursor = { enable = false },
      })
    end,
  },
}
