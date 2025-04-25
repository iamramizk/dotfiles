return {
  "sphamba/smear-cursor.nvim",
  enabled = true,
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

    -- faster
    stiffness = 0.8, -- 0.6      [0, 1]
    trailing_stiffness = 0.5, -- 0.4      [0, 1]
    stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
    trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
    distance_stop_animating = 0.9, -- 0.1      > 0
  },
}
