return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = {
        "*", -- Enable for all filetypes
        css = { css = true }, -- Full CSS support
        scss = { css = true },
        html = { mode = "foreground" },
        "!lazy", -- Disable in lazy.nvim windows
      },
      user_default_options = {
        RGB = true, -- #RGB
        RRGGBB = true, -- #RRGGBB
        names = false, -- Named colors ("red") — can be noisy
        RRGGBBAA = true, -- #RRGGBBAA
        css = false,
        tailwind = true, -- Show Tailwind class colors
        mode = "background", -- "foreground" or "background"
      },
    },
  },
}
