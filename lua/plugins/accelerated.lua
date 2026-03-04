return {
  "rainbowhxch/accelerated-jk.nvim",
  event = "VeryLazy",
  config = function()
    vim.g.accelerated_jk_mode = "time_driven"
    vim.g.accelerated_jk_acceleration_table = { 7, 10, 13, 15, 20 } -- faster speeds
    vim.g.accelerated_jk_enable_deceleration = false
  end,
  keys = {
    { "j", "<Plug>(accelerated_jk_gj)", mode = "n", desc = "Accelerated Down" },
    { "k", "<Plug>(accelerated_jk_gk)", mode = "n", desc = "Accelerated Up" },
  },
}
