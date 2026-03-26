return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
    smear_between_buffers = true,
    smear_between_windows = true,
    scroll_buffer_size = 15,
    stiffness = 0.6,
    trailing_stiffness = 0.3,
    trailing_exponent = 0.1,
    distance_stop_animation = 0.5,
    hide_target_hack = true,
    legacy_computing_symbols_support = false,
    smear_insert_mode = true,
  },
}
