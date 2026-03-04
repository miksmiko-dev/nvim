return {
  -- {
  --   "folke/tokyonight.nvim",
  --   enabled = true,
  --   opts = {
  --     style = "night", -- "night", "moon", "day", "storm"
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  --   on_highlights = function(highlights, colors)
  --     highlights.NormalFloat = { bg = "none" }
  --     highlights.FloatBar = { bg = "none" }
  --     highlights.Pmenu = { bg = "none" }
  --   end,
  --   config = function(_, opts)
  --     require("tokyonight").setup(opts)
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require("github-theme").setup({
  --       options = {
  --         transparent = true,
  --         terminal_colors = false,
  --         styles = {
  --           comments = "italic",
  --           keywords = "bold",
  --           types = "italic,bold",
  --         },
  --       },
  --       palettes = {
  --         github_dark_high_contrast = {},
  --       },
  --     })
  --
  --     vim.cmd("colorscheme github_dark")
  --   end,
  -- },
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
        palettes = {
          github_dark_high_contrast = {},
        },
      })
      -- -- Apply colorscheme
      vim.cmd("colorscheme github_dark")
      -- Make Telescope / floating windows transparent
      local highlights = {
        "NormalFloat",
        "TelescopeNormal",
        "TelescopePromptNormal",
        "TelescopeResultsNormal",
        "TelescopePreviewNormal",
      }
      for _, group in ipairs(highlights) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
      -- Set all Telescope borders to white - use defer to ensure it applies after everything loads
      vim.defer_fn(function()
        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#FFFFFF", bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#FFFFFF", bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#FFFFFF", bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#FFFFFF", bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#FFFFFF", bg = "none" })

        -- Active buffer highlighting
        vim.api.nvim_set_hl(0, "BufferCurrent", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferCurrentIndex", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferCurrentMod", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = "#FFFFFF", bg = "none", italic = true })
        vim.api.nvim_set_hl(0, "BufferCurrentTarget", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })

        -- For built-in tabline (if not using barbar/bufferline)
        vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })

        -- For nvim-bufferline.lua plugin (if using)
        vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferLineNumbersSelected", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#FFFFFF", bg = "none", italic = true })

        -- For barbar.nvim plugin (if using)
        vim.api.nvim_set_hl(0, "BufferCurrent", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferCurrentMod", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })

        -- Active buffer with diagnostics (barbar.nvim)
        vim.api.nvim_set_hl(0, "BufferCurrentERROR", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferCurrentWARN", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferCurrentINFO", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferCurrentHINT", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })

        -- Active buffer with diagnostics (nvim-bufferline.lua)
        vim.api.nvim_set_hl(0, "BufferLineErrorSelected", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferLineWarningSelected", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferLineInfoSelected", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "BufferLineHintSelected", { fg = "#FFFFFF", bg = "none", bold = true, italic = true })
      end, 100)
      -- Configure Telescope to use borders
      -- local telescope_ok, telescope = pcall(require, "telescope")
      -- if telescope_ok then
      --   telescope.setup({
      --     defaults = {
      --       borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      --       winblend = 0,
      --     },
      --     pickers = {
      --       find_files = {
      --         borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      --       },
      --       live_grep = {
      --         borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      --       },
      --       buffers = {
      --         borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      --       },
      --     },
      --   })
      -- end
    end,
  },
  -- {
  --   "Mofiqul/vscode.nvim",
  --   lazy = false,
  --   priority = 1000, -- load before other plugins
  --   config = function()
  --     local c = require("vscode.colors").get_colors()
  --     require("vscode").setup({
  --       -- optional config
  --       transparent = true,
  --       italic_comments = true,
  --       -- disable_nvimtree_bg = true,
  --     })
  --     vim.cmd.colorscheme("vscode")
  --
  --     -- Make terminal background transparent
  --     local function set_transparent()
  --       vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --       vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  --       vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  --       vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  --       vim.api.nvim_set_hl(0, "SnacksTerminal", { bg = "none" })
  --     end
  --
  --     set_transparent()
  --   end,
  -- },
  --
  -- -- Tell LazyVim to use this colorscheme
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "vscode",
  --   },
  -- },
}
