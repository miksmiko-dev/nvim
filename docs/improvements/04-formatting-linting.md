# 04 – Formatting & Linting

## Current State

Both `conform.nvim` (formatting) and `nvim-lint` (linting) are already in your `lazy-lock.json`
— they come with LazyVim — but neither is configured for your stack. You have `vim.g.autoformat = true`
in `options.lua` but no formatter is wired up for JS/TS files.

---

## Option A — Enable LazyVim Extras (Easiest)

In `:LazyExtras`, enable:
- `lazyvim.plugins.extras.formatting.prettier`
- `lazyvim.plugins.extras.linting.eslint`

This configures everything below automatically. Skip to "Per-project config" if you go this route.

---

## Option B — Manual Configuration

### conform.nvim (Prettier)

```lua
-- lua/plugins/formatting.lua  (new file)
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- JS/TS family
        javascript        = { "prettier" },
        javascriptreact   = { "prettier" },
        typescript        = { "prettier" },
        typescriptreact   = { "prettier" },
        -- Web
        html              = { "prettier" },
        css               = { "prettier" },
        scss              = { "prettier" },
        -- Data / Config
        json              = { "prettier" },
        jsonc             = { "prettier" },
        yaml              = { "prettier" },
        markdown          = { "prettier" },
        -- GraphQL (common with Prisma/NextJS)
        graphql           = { "prettier" },
      },
      -- Format on save
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,  -- Fall back to LSP formatter if prettier not found
      },
    },
  },
}
```

### nvim-lint (ESLint)

```lua
-- Add to lua/plugins/formatting.lua or a new lua/plugins/linting.lua
{
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      javascript      = { "eslint_d" },   -- eslint_d is faster (daemon)
      javascriptreact = { "eslint_d" },
      typescript      = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
},
```

> **Note:** Use `eslint_d` (eslint daemon) instead of `eslint` for much faster linting.
> Install it via Mason: `:MasonInstall eslint_d`

---

## Per-Project Config Detection

Prettier and ESLint both respect project-local config files automatically:

| Tool | Config files detected |
|------|-----------------------|
| Prettier | `.prettierrc`, `.prettierrc.json`, `.prettierrc.js`, `prettier.config.js` |
| ESLint | `.eslintrc`, `.eslintrc.json`, `.eslintrc.js`, `eslint.config.js` (flat config) |

No extra Neovim config needed — both tools walk up the directory tree to find configs.

---

## Toggling Format on Save

LazyVim's `<leader>uf` toggles format-on-save at runtime. This is already wired up.

To disable autoformat for a specific filetype project-wide, add to `lua/plugins/formatting.lua`:

```lua
-- Disable autoformat for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },   -- Example: don't format SQL with prettier
  callback = function()
    vim.b.autoformat = false
  end,
})
```

---

## Recommended Prettier Config for Next.js / NestJS Projects

A baseline `.prettierrc` that works well across your stack:

```json
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 100,
  "tabWidth": 2,
  "plugins": ["prettier-plugin-tailwindcss"]
}
```

> `prettier-plugin-tailwindcss` auto-sorts Tailwind classes in JSX. Install with:
> `npm install -D prettier-plugin-tailwindcss`

---

## Keybinding Reference

| Key | Action |
|-----|--------|
| `<leader>uf` | Toggle format on save |
| `<leader>cf` | Format current buffer manually |
| `<leader>ux` | Toggle diagnostics (linting visibility) |
