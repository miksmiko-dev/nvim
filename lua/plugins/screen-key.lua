return {
  "NStefan002/screenkey.nvim",
  lazy = false,
  config = function()
    require("screenkey").setup({
      win_opts = {
        relative = "editor",
        anchor = "SE",
        width = 30,
        height = 1,
        border = "none",
        style = "minimal",
        focusable = false,
        zindex = 100,
      },
      compress_after = 999,
      clear_after = 3,
      disable = {
        filetypes = {},
        buftypes = {},
      },
      show_leader = true,
      group_mappings = false, -- Disable grouping to show one at a time
      separator = "",
      keys = {
        ["<leader>"] = " spcl",
        ["<Space>"] = " spc",
        ["<cr>"] = "↵",
        ["<Tab>"] = " Tab",
        ["<Esc>"] = " Esc",
        ["<bs>"] = "⌫",
        ["<Del>"] = " Del",
        ["<Left>"] = "←",
        ["<Right>"] = "→",
        ["<Up>"] = "↑",
        ["<Down>"] = "↓",
      },
    })

    -- Custom highlighting
    vim.api.nvim_set_hl(0, "ScreenkeysNormal", { bg = "#1e1e2e", fg = "#cdd6f4", bold = true })
    vim.api.nvim_set_hl(0, "ScreenkeysBorder", { fg = "#89b4fa" })
    vim.cmd("Screenkey")
  end,
}
