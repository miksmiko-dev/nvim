return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- cursor_color = "#00fa9a", -- tropical apple green
    smear_length = 14, -- longer trail
    smear_fade_time = 250, -- slower fade
    smear_easing = "inOutQuad", -- smoother easing
    keep_trail_on_line_change = true,
  },
}
