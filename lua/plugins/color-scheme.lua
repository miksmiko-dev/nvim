return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          terminal_colors = false,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
      })
      vim.cmd("colorscheme github_dark")

      -- Transparent floats and Telescope windows
      for _, group in ipairs({
        "NormalFloat",
        "TelescopeNormal",
        "TelescopePromptNormal",
        "TelescopeResultsNormal",
        "TelescopePreviewNormal",
      }) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end

      -- Borders and active buffer — deferred to ensure they apply after all plugins load
      vim.defer_fn(function()
        for _, group in ipairs({
          "TelescopeBorder",
          "TelescopePromptBorder",
          "TelescopeResultsBorder",
          "TelescopePreviewBorder",
          "FloatBorder",
        }) do
          vim.api.nvim_set_hl(0, group, { fg = "#FFFFFF", bg = "none" })
        end

        -- Active buffer (nvim-bufferline)
        for _, group in ipairs({
          "BufferLineBufferSelected",
          "BufferLineNumbersSelected",
          "BufferLineCloseButtonSelected",
          "BufferLineErrorSelected",
          "BufferLineWarningSelected",
          "BufferLineInfoSelected",
          "BufferLineHintSelected",
          "TabLineSel",
        }) do
          vim.api.nvim_set_hl(0, group, { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        end
      end, 100)
    end,
  },
}
