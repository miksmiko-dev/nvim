-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   opts = {
--     filesystem = {
--       renderers = {
--         root = {
--           { "indent" },
--         },
--       },
--       filtered_items = {
--         visible = true,
--         hide_dotfiles = false,
--         hide_gitignored = false,
--       },
--       follow_current_file = {
--         enabled = true, -- This ensures the current file is focused
--         leave_dirs_open = false,
--       },
--       hijack_netrw_behavior = "open_current",
--     },
--     window = {
--       position = "float",
--       popup = {
--         size = {
--           height = "80%",
--           width = "60%",
--         },
--         show_title = false,
--       },
--     },
--   },
--   keys = {
--     {
--       "<leader>e",
--       function()
--         require("neo-tree.command").execute({ toggle = true, reveal = true })
--       end,
--       desc = "Toggle Neo-tree (Floating & Reveal Current File)",
--     },
--   },
-- }
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    priority = 1001,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      source_selector = {
        winbar = false,
        statusline = false,
      },
      filesystem = {
        renderers = {
          root = {
            { "indent" }, -- remove root label/snack
          },
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        hijack_netrw_behavior = "open_current",
      },
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      git_status = {
        window = {
          mappings = {
            ["A"] = "git_add_all",
          },
        },
      },
      window = {
        position = "float",
        popup = {
          size = {
            height = "80%",
            width = "60%",
          },
          show_title = false,
          border = "rounded",
          position = "50%",
        },
      },
    },
    keys = {
      {
        "<leader>F",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            reveal = true,
            source = "filesystem",
          })
        end,
        desc = "Toggle Neo-tree (Floating & Reveal Current File)",
      },
      {
        "<leader>b",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "buffers",
          })
        end,
        desc = "Toggle Buffers in Neo-tree (Floating)",
      },
      {
        "<leader>g",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "git_status",
          })
        end,
        desc = "Toggle Git in Neo-tree (Floating)",
      },
    },
  },

  -- 🍭 Snacks Notification UI Enhancement
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.explorer.enabled = true -- keep snacks explorer if you want
      opts.notify = {
        backend = "nui",
        level = vim.log.levels.INFO,
        render = "minimal",
        stages = "fade_in_slide_out",
        timeout = 4000,
        max_width = 80,
        icons = {
          INFO = "",
          WARN = "",
          ERROR = "",
          DEBUG = "",
          TRACE = "✎",
        },
      }
      opts.notify_view = {
        backend = "nui",
        view = "float",
        opts = {
          border = "rounded",
          position = "top_right",
          relative = "editor",
          winblend = 10,
        },
      }
      opts.messages = {
        enabled = true,
        view = "mini",
      }
    end,
  },
}
