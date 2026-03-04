# 03 – DAP Debugging Improvements

## Current State

Your `dap.lua` handles Node.js (launch/attach) and Chrome, which covers basic React/Express
debugging. Missing: **NestJS**, **Next.js** (both server + client), and **Jest** debug configs.

---

## Add These Configurations to `dap.lua`

Inside the `config = function()` block of `mfussenegger/nvim-dap`, extend the existing
`dap.configurations` loop or add a separate block after it:

### NestJS Debug Config

```lua
-- Add after your existing js_based_languages loop
-- NestJS runs as a Node process — use pwa-node with ts-node
dap.configurations.typescript = dap.configurations.typescript or {}
vim.list_extend(dap.configurations.typescript, {
  {
    name = "NestJS: Launch",
    type = "pwa-node",
    request = "launch",
    runtimeExecutable = "node",
    runtimeArgs = {
      "--require", "ts-node/register",
      "--require", "tsconfig-paths/register",
    },
    args = { "${workspaceFolder}/src/main.ts" },
    rootPath = "${workspaceFolder}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    protocol = "inspector",
    console = "integratedTerminal",
    env = {
      NODE_ENV = "development",
    },
    outFiles = { "${workspaceFolder}/dist/**/*.js" },
  },
  {
    name = "NestJS: Attach (port 9229)",
    type = "pwa-node",
    request = "attach",
    port = 9229,
    restart = true,
    rootPath = "${workspaceFolder}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    -- Start NestJS with: node --inspect -r ts-node/register src/main.ts
  },
})
```

**To start NestJS in debug mode from terminal:**
```sh
node --inspect -r ts-node/register -r tsconfig-paths/register src/main.ts
# or with nodemon:
nodemon --inspect --exec ts-node -r tsconfig-paths/register src/main.ts
```

---

### Next.js Debug Configs

```lua
-- Next.js server-side (Node) + client-side (Chrome)
dap.configurations.typescriptreact = dap.configurations.typescriptreact or {}
vim.list_extend(dap.configurations.typescriptreact, {
  {
    name = "Next.js: Debug Server-Side",
    type = "pwa-node",
    request = "attach",
    port = 9229,
    skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    -- Start Next.js with: NODE_OPTIONS='--inspect' next dev
  },
  {
    name = "Next.js: Debug Client-Side (Chrome)",
    type = "pwa-chrome",
    request = "launch",
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
    sourceMaps = true,
    sourceMapPathOverrides = {
      -- Map Next.js internal paths to source files
      ["webpack://_N_E/*"] = "${webRoot}/*",
      ["webpack:///./*"] = "${webRoot}/.next/static/chunks/./*",
    },
  },
  {
    name = "Next.js: Full-Stack (Server + Client)",
    type = "pwa-chrome",
    request = "launch",
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
    sourceMaps = true,
    -- First start Next.js with NODE_OPTIONS='--inspect' next dev
    -- then use this to attach Chrome debugger for client-side
    sourceMapPathOverrides = {
      ["webpack://_N_E/*"] = "${webRoot}/*",
    },
  },
})
```

**To start Next.js in debug mode:**
```sh
NODE_OPTIONS='--inspect' next dev
# or add to package.json scripts:
# "debug": "NODE_OPTIONS='--inspect' next dev"
```

---

### Jest Debug Config

```lua
-- Works for both unit tests and integration tests
for _, language in ipairs(js_based_languages) do
  vim.list_extend(dap.configurations[language] or {}, {
    {
      name = "Jest: Debug Current File",
      type = "pwa-node",
      request = "launch",
      runtimeExecutable = "node",
      runtimeArgs = {
        "--experimental-vm-modules",
        "${workspaceFolder}/node_modules/.bin/jest",
        "--runInBand",
        "--testPathPattern", "${file}",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**" },
    },
    {
      name = "Jest: Debug All Tests",
      type = "pwa-node",
      request = "launch",
      runtimeExecutable = "node",
      runtimeArgs = {
        "${workspaceFolder}/node_modules/.bin/jest",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**" },
    },
  })
end
```

---

## Add nvim-dap-ui (Visual Debug Interface)

Currently you have no DAP UI. Add this to `dap.lua` dependencies or as a new file:

```lua
-- lua/plugins/dap-ui.lua  (new file)
return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
      { "<leader>de", function() require("dapui").eval() end, desc = "DAP Eval", mode = { "n", "v" } },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes",      size = 0.40 },
              { id = "breakpoints", size = 0.15 },
              { id = "stacks",      size = 0.25 },
              { id = "watches",     size = 0.20 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 12,
            position = "bottom",
          },
        },
      })

      -- Auto-open UI when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- Auto-close UI when debugging ends
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Shows variable values inline while debugging
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    opts = {
      enabled = true,
      all_frames = false,        -- Only show for current frame
      virt_text_pos = "eol",     -- Show at end of line
      highlight_changed_variables = true,
    },
  },
}
```

---

## Recommended `.vscode/launch.json` Template

For projects where you share debug configs with your team (works with `<leader>da`):

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "NestJS: Launch",
      "type": "node",
      "request": "launch",
      "runtimeArgs": ["--require", "ts-node/register"],
      "args": ["${workspaceFolder}/src/main.ts"],
      "sourceMaps": true,
      "skipFiles": ["<node_internals>/**"]
    },
    {
      "name": "Next.js: Server",
      "type": "node",
      "request": "attach",
      "port": 9229,
      "sourceMaps": true
    }
  ]
}
```
