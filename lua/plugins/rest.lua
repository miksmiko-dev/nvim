return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>rr", "<cmd>lua require('kulala').run()<cr>", desc = "Run Request" },
      { "<leader>rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next Request" },
      { "<leader>rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Prev Request" },
    },
    opts = {
      default_view = "body",
      default_env = "dev",
    },
  },
}
