# 06 – Testing with Neotest

## Overview

`neotest` gives you a unified testing interface — run individual tests, entire files, or full
suites without leaving Neovim. The LazyVim `test.core` extra installs the base framework;
you add the adapter for your specific test runner.

---

## Step 1 — Enable the Base Extra

In `:LazyExtras`, enable `lazyvim.plugins.extras.test.core`.

Or add to `lazyvim.json` extras array: `"lazyvim.plugins.extras.test.core"`

---

## Step 2 — Add the Jest / Vitest Adapter

```lua
-- lua/plugins/testing.lua  (new file)
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Pick one (or both):
      "marilari88/neotest-vitest",   -- for Vitest (Next.js / modern projects)
      "haydenmeade/neotest-jest",    -- for Jest (NestJS / older projects)
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      -- Vitest adapter (auto-detects vitest.config.ts / package.json)
      table.insert(opts.adapters, require("neotest-vitest")({
        -- Only use for projects with vitest
        filter_dir = function(name)
          return name ~= "node_modules"
        end,
      }))

      -- Jest adapter (auto-detects jest.config.ts / package.json jest field)
      table.insert(opts.adapters, require("neotest-jest")({
        jestCommand = "npx jest",
        jestConfigFile = "jest.config.ts",
        env = { CI = "true" },
        cwd = function()
          return vim.fn.getcwd()
        end,
      }))
    end,
    keys = {
      -- Run nearest test to cursor
      { "<leader>tt", function() require("neotest").run.run() end,                   desc = "Run Nearest Test" },
      -- Run all tests in current file
      { "<leader>tT", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File Tests" },
      -- Run entire test suite
      { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end,    desc = "Run All Tests" },
      -- Debug nearest test (uses DAP)
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest Test" },
      -- Toggle test output panel
      { "<leader>to", function() require("neotest").output_panel.toggle() end,       desc = "Toggle Output Panel" },
      -- Toggle test summary sidebar
      { "<leader>ts", function() require("neotest").summary.toggle() end,            desc = "Toggle Test Summary" },
      -- Jump to next failed test
      { "]t",         function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next Failed Test" },
      { "[t",         function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Prev Failed Test" },
    },
  },
}
```

---

## Keybinding Summary

| Key | Action |
|-----|--------|
| `<leader>tt` | Run nearest test (under cursor) |
| `<leader>tT` | Run all tests in current file |
| `<leader>ta` | Run entire test suite |
| `<leader>td` | Debug nearest test (opens DAP) |
| `<leader>to` | Toggle test output panel |
| `<leader>ts` | Toggle test summary sidebar |
| `]t` | Jump to next failed test |
| `[t` | Jump to prev failed test |
| `<leader>tf` | Find TODOs with Telescope (existing) |

> Note: `<leader>t` prefix is shared with your existing `todo-comments` binding (`<leader>tf`).
> The test bindings above use `tt`, `tT`, `ta`, `td`, `to`, `ts` which don't conflict.

---

## NestJS Jest Configuration

NestJS projects use Jest with ts-jest. A minimal `jest.config.ts` for NestJS:

```typescript
import type { Config } from 'jest'

const config: Config = {
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: 'src',
  testRegex: '.*\\.spec\\.ts$',
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
  collectCoverageFrom: ['**/*.(t|j)s'],
  coverageDirectory: '../coverage',
  testEnvironment: 'node',
}

export default config
```

## Next.js / Vitest Configuration

Next.js 14+ projects can use Vitest for unit tests. A minimal `vitest.config.ts`:

```typescript
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import tsconfigPaths from 'vite-tsconfig-paths'

export default defineConfig({
  plugins: [react(), tsconfigPaths()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: './src/test/setup.ts',
  },
})
```

---

## How Neotest Finds Tests

Neotest reads your project config automatically:
- Detects `jest.config.*` or `"jest"` in `package.json` → uses Jest adapter
- Detects `vitest.config.*` or `"vitest"` in `package.json` → uses Vitest adapter
- Shows pass/fail icons in the gutter next to each `it()`/`test()` block
- Test output appears in the output panel (`<leader>to`)
