return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
    smear_between_buffers = false,
    stiffness = 0.9,
    trailing_stiffness = 0.8,
    distance_stop_animation = 0.3,
    -- cursor_color = "#00fa9a", -- tropical apple green
    -- smear_length = 14, -- longer trail
    -- smear_fade_time = 250, -- slower fade
    -- smear_easing = "inOutQuad", -- smoother easing
    -- keep_trail_on_line_change = true,
  },
}
