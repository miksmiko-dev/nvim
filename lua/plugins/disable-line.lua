return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      highlight = "IblIndent",
    },
    whitespace = {
      highlight = "IblWhitespace",
      remove_blankline_trail = true,
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
  },
  config = function(_, opts)
    -- Apply the plugin setup
    require("ibl").setup(opts)

    -- Set highlight colors (adjust guifg to your preferred gray)
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#666666", nocombine = true })
    vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#666666", nocombine = true })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#888888", nocombine = true })
  end,
}
