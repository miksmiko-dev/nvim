# Neovim Config Improvement Plan

Tech stack: **ReactJS · NextJS · NodeJS · ExpressJS · NestJS · Prisma · TypeORM**

This folder documents proposed improvements to your LazyVim configuration. Nothing in your
existing config has been touched. Read each file, pick what you want, and apply it yourself.

---

## Index

| File | Topic | Priority |
|------|-------|----------|
| [01-lsp.md](./01-lsp.md) | Language Servers – fix deprecated plugin, add Tailwind/Prisma/ESLint LSPs | HIGH |
| [02-lazyvim-extras.md](./02-lazyvim-extras.md) | LazyVim Extras – zero-config toggle-ons for your stack | HIGH |
| [03-dap-debugging.md](./03-dap-debugging.md) | Debugging – NestJS, NextJS, Jest debug configs + DAP UI | HIGH |
| [04-formatting-linting.md](./04-formatting-linting.md) | Formatting & Linting – conform.nvim + nvim-lint (both already in lock file) | HIGH |
| [05-snippets.md](./05-snippets.md) | Snippets – React, NestJS, Express, Prisma, TypeORM custom snippets | MEDIUM |
| [06-testing.md](./06-testing.md) | Testing – neotest + vitest/jest adapter | MEDIUM |
| [07-new-plugins.md](./07-new-plugins.md) | New Plugins – Harpoon, REST client, package.json info, colorizer | MEDIUM |
| [08-git.md](./08-git.md) | Git – Diffview, Neogit / Lazygit | LOW |
| [09-ai-completions.md](./09-ai-completions.md) | AI Completions – GitHub Copilot or Codeium | LOW |

---

## Quick Wins (do these first)

1. **Fix the deprecated `typescript.nvim`** → see [01-lsp.md](./01-lsp.md)
2. **Enable LazyVim extras** via `:LazyExtras` UI → see [02-lazyvim-extras.md](./02-lazyvim-extras.md)
3. **Configure conform.nvim with prettier** → see [04-formatting-linting.md](./04-formatting-linting.md)
4. **Add NestJS / NextJS debug configs to dap.lua** → see [03-dap-debugging.md](./03-dap-debugging.md)

---

## How LazyVim Extras Work

LazyVim ships with pre-built "extras" that bundle LSPs, formatters, treesitter grammars, and
keymaps for specific languages/tools. You can toggle them interactively:

```
:LazyExtras
```

Or by editing `lazyvim.json` directly (see [02-lazyvim-extras.md](./02-lazyvim-extras.md)).
Extras are the fastest way to get production-ready language support with zero boilerplate.
