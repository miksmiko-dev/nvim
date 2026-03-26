return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    keys = {
      { "<leader>sr", '<cmd>lua require("spectre").open()<cr>', desc = "Spectre: Find & Replace (Project)" },
      {
        "<leader>sw",
        '<cmd>lua require("spectre").open_visual({ select_word = true })<cr>',
        desc = "Spectre: Search Current Word",
      },
      {
        "<leader>sf",
        '<cmd>lua require("spectre").open_file_search()<cr>',
        desc = "Spectre: Find & Replace (Current File)",
      },
    },
    opts = {
      open_cmd = "noswapfile vnew",
    },
  },
}
