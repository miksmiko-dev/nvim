return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
      -- scale image to fit terminal (max width/height)
      max_width = 40, -- adjust to your terminal width in columns
      max_height = 12, -- adjust to your terminal height in rows
      -- center it visually
      position = function(img_width, img_height)
        local wezterm = require("wezterm")
        local size = wezterm.gui.get_window_size()
        local term_cols, term_rows = size.cols, size.rows

        -- center in terminal
        local col = math.floor((term_cols - img_width) / 2)
        local row = math.floor((term_rows - img_height) / 2)
        return { col = col, row = row }
      end,
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
