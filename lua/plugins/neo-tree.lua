return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
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
          hide_gitignored = true,
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
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            reveal = true,
            source = "filesystem",
          })
        end,
        desc = "Toggle Neo-tree (Floating & Reveal Current File)",
      },
      -- {
      --   "<leader>F",
      --   function()
      --     require("neo-tree.command").execute({
      --       toggle = true,
      --       reveal = true,
      --       source = "filesystem",
      --     })
      --   end,
      --   desc = "Toggle Neo-tree (Floating & Reveal Current File)",
      -- },
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
    keys = {
      { "<leader>e", false }, -- let neo-tree own <leader>e
    },
    opts = function(_, opts)
      opts.explorer = { enabled = false } -- neo-tree handles file exploration
      opts.indent = {
        indent = { enabled = false }, -- hide guides on all lines
        scope = { enabled = true },   -- show guide only for current scope
      }
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
