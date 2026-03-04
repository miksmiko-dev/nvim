return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy", -- load lazily
  opts = {},
  config = function(_, opts)
    require("todo-comments").setup(opts)

    vim.keymap.set("n", "<leader>tf", "<cmd>TodoTelescope<CR>", { desc = "Find todos (Telescope)" })
    -- vim.keymap.set("n", "<leader>tf1", "<cmd>TodoTrouble<CR>", { desc = "Todos (Trouble)" })
  end,
}
