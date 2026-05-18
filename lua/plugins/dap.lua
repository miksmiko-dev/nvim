local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      local Config = require("lazyvim.config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Next.js: server-side debugging
          -- Start Next.js with: NODE_OPTIONS='--inspect' next dev
          {
            name = "Next.js: Debug Server-Side",
            type = "pwa-node",
            request = "attach",
            port = 9229,
            skipFiles = { "<node_internals>/**", "**/node_modules/**" },
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
          -- Next.js: client-side debugging via Chrome
          {
            name = "Next.js: Debug Client-Side (Chrome)",
            type = "pwa-chrome",
            request = "launch",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
            sourceMapPathOverrides = {
              ["webpack://_N_E/*"] = "${webRoot}/*",
              ["webpack:///./*"] = "${webRoot}/.next/static/chunks/./*",
            },
          },
          -- Next.js: full-stack (attach Chrome after starting server with --inspect)
          {
            name = "Next.js: Full-Stack (Server + Client)",
            type = "pwa-chrome",
            request = "launch",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
            sourceMapPathOverrides = {
              ["webpack://_N_E/*"] = "${webRoot}/*",
            },
          },
          -- Debug a single Node.js file
          {
            name = "Launch",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            protocol = "inspector",
            console = "integratedTerminal",
          },
          -- Attach to a running Node.js process
          {
            name = "Attach to node process",
            type = "pwa-node",
            request = "attach",
            rootPath = "${workspaceFolder}",
            processId = require("dap.utils").pick_process,
          },
          -- Launch Chrome with a prompted URL
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          },
          -- Divider for launch.json derived configs
          {
            name = "----- ↓ launch.json configs ↓ -----",
            type = "",
            request = "launch",
          },
        }
      end
    end,

    keys = {
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>da",
        function()
          if vim.fn.filereadable(".vscode/launch.json") then
            local dap_vscode = require("dap.ext.vscode")
            dap_vscode.load_launchjs(nil, {
              ["pwa-node"] = js_based_languages,
              ["chrome"] = js_based_languages,
              ["pwa-chrome"] = js_based_languages,
            })
          end
          require("dap").continue()
        end,
        desc = "Run with Args",
      },
    },

    dependencies = {
      -- Install the vscode-js-debug adapter.
      -- After install, build it and rename dist -> out.
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps --no-save --ignore-scripts && npx gulp vsDebugServerBundle && mv dist out",
        version = "1.*",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup({
            -- debugger_path is unused when debugger_cmd is set,
            -- but kept here as a reference for the install location.
            -- debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/"),

            -- Explicit command takes precedence over debugger_path.
            debugger_cmd = { "js-debug-adapter" },

            adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
            },
          })
        end,
      },
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
  },
}
