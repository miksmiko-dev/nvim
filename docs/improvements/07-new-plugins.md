# 07 – New Plugins to Add

Plugins that don't fit neatly into other categories but would significantly improve your
daily development workflow.

---

## Harpoon 2 — Fast File Navigation

The most impactful addition for a React/NestJS workflow. You constantly jump between related
files: `user.controller.ts` ↔ `user.service.ts` ↔ `user.module.ts` ↔ `user.spec.ts`, or
`page.tsx` ↔ `page.test.tsx` ↔ `page.module.css`.

Harpoon lets you pin up to 4 files and jump to them instantly with `<C-1>` through `<C-4>`.

**Option A:** Enable via `:LazyExtras` → `lazyvim.plugins.extras.editor.harpoon2`

**Option B:** Manual config:

```lua
-- lua/plugins/harpoon.lua  (new file)
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end,           desc = "Harpoon Add File" },
      { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Menu" },
      { "<C-1>",      function() require("harpoon"):list():select(1) end,       desc = "Harpoon File 1" },
      { "<C-2>",      function() require("harpoon"):list():select(2) end,       desc = "Harpoon File 2" },
      { "<C-3>",      function() require("harpoon"):list():select(3) end,       desc = "Harpoon File 3" },
      { "<C-4>",      function() require("harpoon"):list():select(4) end,       desc = "Harpoon File 4" },
    },
    opts = {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    },
  },
}
```

**Workflow:**
1. Open `user.service.ts` → `<leader>ha` (pin to slot 1)
2. Open `user.controller.ts` → `<leader>ha` (pin to slot 2)
3. Anywhere in your project: `<C-1>` jumps back to service, `<C-2>` to controller

---

## Kulala.nvim — HTTP/REST Client

Test your Express/NestJS APIs directly from Neovim using `.http` files. No Postman/Insomnia needed.

```lua
-- lua/plugins/rest.lua  (new file)
return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>rr", function() require("kulala").run() end,        desc = "REST: Run Request" },
      { "<leader>ra", function() require("kulala").run_all() end,    desc = "REST: Run All" },
      { "<leader>rp", function() require("kulala").jump_prev() end,  desc = "REST: Prev Request" },
      { "<leader>rn", function() require("kulala").jump_next() end,  desc = "REST: Next Request" },
      { "<leader>ri", function() require("kulala").inspect() end,    desc = "REST: Inspect" },
    },
    opts = {
      default_view = "body",     -- Show response body by default
      default_env = "dev",
      debug = false,
      display_mode = "split",
    },
  },
}
```

**Usage — create a `.http` file in your project:**

```http
# @name GetUsers
GET http://localhost:3000/api/users
Authorization: Bearer {{token}}
Content-Type: application/json

###

# @name CreateUser
POST http://localhost:3000/api/users
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}

###

# @name LoginAndSaveToken
# @prompt username Enter username
POST http://localhost:3000/auth/login
Content-Type: application/json

{
  "username": "{{username}}",
  "password": "secret"
}
```

Place environment variables in `.env` or a `kulala.env.json` file:
```json
{
  "dev": {
    "token": "your-dev-jwt-token",
    "BASE_URL": "http://localhost:3000"
  },
  "prod": {
    "BASE_URL": "https://api.yourapp.com"
  }
}
```

---

## package-info.nvim — package.json Management

Shows npm package versions inline in `package.json` and lets you update/delete them without
leaving the editor.

```lua
-- lua/plugins/package-info.lua  (new file)
return {
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048",  -- Gray for up-to-date
          outdated   = "#d19a66",  -- Orange for outdated
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated   = "|  ",
          },
        },
        autostart = true,           -- Show versions when opening package.json
        hide_up_to_date = false,
        hide_unstable_versions = false,
        package_manager = "npm",    -- Change to "yarn" or "pnpm" if needed
      })
    end,
    keys = {
      { "<leader>ns", function() require("package-info").show() end,    desc = "Show package versions",    ft = "json" },
      { "<leader>nc", function() require("package-info").hide() end,    desc = "Hide package versions",    ft = "json" },
      { "<leader>nu", function() require("package-info").update() end,  desc = "Update package",           ft = "json" },
      { "<leader>nd", function() require("package-info").delete() end,  desc = "Delete package",           ft = "json" },
      { "<leader>ni", function() require("package-info").install() end, desc = "Install new package",      ft = "json" },
      { "<leader>np", function() require("package-info").change_version() end, desc = "Change version",   ft = "json" },
    },
  },
}
```

---

## nvim-colorizer.lua — CSS Color Previews

Shows color swatches inline for CSS, Tailwind, and any hex/rgb color in your code.

```lua
-- lua/plugins/colorizer.lua  (new file)
return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = {
        "*",             -- Enable for all filetypes
        css = { css = true },                    -- Full CSS support
        scss = { css = true },
        html = { mode = "foreground" },
        "!lazy",         -- Disable in lazy.nvim windows
      },
      user_default_options = {
        RGB       = true,    -- #RGB
        RRGGBB    = true,    -- #RRGGBB
        names     = false,   -- Named colors ("red") — can be noisy
        RRGGBBAA  = true,    -- #RRGGBBAA
        css       = false,
        tailwind  = "both",  -- Show Tailwind class colors (requires tailwindcss LSP)
        mode      = "background",  -- "foreground" or "background"
      },
    },
  },
}
```

---

## better-escape.nvim — Escape Insert Mode Faster

Replaces the jarring `<Esc>` key with a key chord that doesn't delay character input:

```lua
-- lua/plugins/better-escape.lua  (new file)
return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      timeout = vim.o.timeoutlen,
      default_mappings = false,
      mappings = {
        i = { j = { k = "<Esc>" } },  -- Press 'jk' fast to exit insert mode
        c = { j = { k = "<Esc>" } },
      },
    },
  },
}
```

---

## Prisma Syntax (if not using the LazyVim extra)

If you don't want the full `lang.prisma` extra, you can add minimal Prisma support:

```lua
-- lua/plugins/prisma.lua  (new file)
return {
  {
    "prisma/vim-prisma",
    ft = "prisma",
  },
}
```

Add filetype detection to `lua/config/autocmds.lua`:
```lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.prisma",
  callback = function()
    vim.bo.filetype = "prisma"
  end,
})
```
