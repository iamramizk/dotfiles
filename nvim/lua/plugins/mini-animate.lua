return {
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
}
