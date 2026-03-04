return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = function(_, opts)
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      file_ignore_patterns = { "node_modules", ".git" },
    })
    opts.pickers = {
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end,
      },
    }
    opts.extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("ui-select")
  end,
}
