return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      shade_terminals = false,
      shell = "zsh --login",
      direction = "float",
      float_opts = {
        border = "curved",
        -- Set to 80% of window size
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 0,
      },
      highlights = {
        FloatBorder = { link = "Normal" },
        Normal = { link = "Normal" },
      },
    })
  end,
  keys = {
    { [[<C-\>]] },
    { "<leader>1", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
    {
      "<leader>R",
      "<cmd>ToggleTerm direction=float<cr>",
      desc = "Open a floating terminal",
    },
  },
}
