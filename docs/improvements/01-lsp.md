# 01 – LSP Improvements

## Problem: `typescript.nvim` is Archived / Deprecated

Your current `lua/plugins/typescript.lua`:
```lua
return {
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/typescript.nvim" },  -- ⚠ archived, no longer maintained
}
```

`jose-elias-alvarez/typescript.nvim` has been archived since 2023. It still works but gets no
bug fixes, and it conflicts with newer LSP setups.

---

## Option A — Use LazyVim's Built-in TypeScript Extra (Recommended)

The cleanest fix is to delete `lua/plugins/typescript.lua` entirely and enable the LazyVim
extra instead (see `02-lazyvim-extras.md`). The extra ships `typescript-tools.nvim` which is
the modern maintained replacement.

If you want to keep the file and just swap the plugin manually:

```lua
-- lua/plugins/typescript.lua
return {
  -- Remove the archived plugin, use typescript-tools instead
  { "jose-elias-alvarez/typescript.nvim", enabled = false },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        -- Publish diagnostics on change (not just save)
        publish_diagnostic_on = "insert_leave",
        -- Expose full TypeScript server capabilities
        expose_as_code_action = "all",
        -- Faster tsserver by separating processes
        separate_diagnostic_server = true,
        -- Show inlay hints
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayReturnTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },
}
```

---

## Missing LSPs for Your Stack

Mason (bundled with LazyVim) can auto-install these. Add them via `lua/plugins/lsp.lua`:

```lua
-- lua/plugins/lsp.lua  (new file)
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- Ensure these are always installed
      vim.list_extend(opts.ensure_installed, {
        -- TypeScript / JavaScript
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        -- React / Next.js
        "tailwindcss-language-server",
        "emmet-language-server",
        -- Prisma
        "prisma-language-server",
        -- JSON / YAML (configs everywhere)
        "json-lsp",
        "yaml-language-server",
        -- Docker (common in Next/Node projects)
        "dockerfile-language-server",
        "docker-compose-language-service",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Tailwind CSS (React/Next.js)
        tailwindcss = {
          filetypes = {
            "html", "css", "scss",
            "javascript", "javascriptreact",
            "typescript", "typescriptreact",
          },
          settings = {
            tailwindCSS = {
              -- Detect Tailwind in Next.js projects
              experimental = { classRegex = { { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" } } },
            },
          },
        },

        -- Prisma schema files
        prismals = {},

        -- ESLint as a language server (shows errors in real time)
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
          on_attach = function(_, bufnr)
            -- Auto-fix on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        },

        -- Emmet for JSX/TSX (fast HTML/JSX expansion)
        emmet_language_server = {
          filetypes = {
            "html", "css", "scss",
            "javascriptreact", "typescriptreact",
          },
        },

        -- JSON with schema support (package.json, tsconfig.json, etc.)
        jsonls = {
          settings = {
            json = {
              -- Pulls schemas from SchemaStore for package.json, tsconfig, etc.
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        -- YAML (docker-compose, GitHub Actions, etc.)
        yamlls = {
          settings = {
            yaml = {
              schemaStore = { enable = false, url = "" },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
      },
    },
  },

  -- SchemaStore for JSON/YAML validation (package.json, tsconfig, etc.)
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
}
```

---

## Inlay Hints (TypeScript parameter names inline)

LazyVim enables inlay hints by default since v11. If they're not showing, add to `options.lua`:

```lua
vim.lsp.inlay_hint.enable(true)
```

Toggle them at runtime with `<leader>uh` (LazyVim default keybinding).

---

## NestJS-Specific: Decorator Support

NestJS relies heavily on TypeScript decorators (`@Injectable()`, `@Controller()`, etc.).
Make sure your `tsconfig.json` in each project has:
```json
{
  "compilerOptions": {
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true
  }
}
```
The TypeScript LSP reads this and will properly type-check decorators.
