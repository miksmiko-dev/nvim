# 02 – LazyVim Extras

## What Are Extras?

LazyVim ships pre-built bundles for common languages and tools. Each "extra" wires up the
correct LSP, formatter, linter, treesitter grammar, and keybindings — all tested together.
Your current `lazyvim.json` has **no extras enabled**, which means you're missing a lot of
free, well-tested functionality.

## How to Enable

**Method 1 — Interactive UI (easiest):**
```
:LazyExtras
```
Navigate with `j/k`, press `x` to toggle. Changes are written to `lazyvim.json` automatically.

**Method 2 — Edit `lazyvim.json` directly:**
```json
{
  "extras": [
    "lazyvim.plugins.extras.lang.typescript",
    "lazyvim.plugins.extras.lang.tailwind",
    "lazyvim.plugins.extras.lang.prisma",
    "lazyvim.plugins.extras.lang.json",
    "lazyvim.plugins.extras.lang.yaml",
    "lazyvim.plugins.extras.formatting.prettier",
    "lazyvim.plugins.extras.linting.eslint",
    "lazyvim.plugins.extras.test.core",
    "lazyvim.plugins.extras.editor.harpoon2"
  ],
  "install_version": 8,
  "news": { "NEWS.md": "11866" },
  "version": 8
}
```

---

## Recommended Extras for Your Stack

### HIGH priority

#### `lazyvim.plugins.extras.lang.typescript`
What it adds:
- `typescript-tools.nvim` (replaces the archived `typescript.nvim`)
- `nvim-ts-autotag` already in your config — this also enables it properly
- Extra keymaps: `<leader>co` (organize imports), `<leader>cR` (rename file)
- `ts-error-translator.nvim` — translates cryptic TS errors into plain English

> If you enable this extra, you can delete `lua/plugins/typescript.lua` entirely.

#### `lazyvim.plugins.extras.lang.tailwind`
What it adds:
- `tailwindcss-language-server` via Mason
- Class name completions and color previews in JSX/TSX/HTML
- `tailwind-sorter.nvim` (optional, sorts class names)

#### `lazyvim.plugins.extras.lang.prisma`
What it adds:
- `prisma-language-server` via Mason
- Treesitter grammar for `.prisma` files
- Syntax highlighting and completions in schema files

#### `lazyvim.plugins.extras.lang.json`
What it adds:
- `json-lsp` with SchemaStore schemas
- Auto-validates `package.json`, `tsconfig.json`, `.eslintrc`, etc.
- Completions for known JSON schema keys

#### `lazyvim.plugins.extras.formatting.prettier`
What it adds:
- `conform.nvim` configured for prettier (already in your lock file but not configured)
- Format on save for JS/TS/JSX/TSX/JSON/CSS/HTML/YAML/Markdown
- Project-local `.prettierrc` is automatically respected

#### `lazyvim.plugins.extras.linting.eslint`
What it adds:
- `nvim-lint` configured with eslint (already in your lock file but not configured)
- Real-time ESLint diagnostics shown in the gutter
- Works with project-local `.eslintrc.*` files

### MEDIUM priority

#### `lazyvim.plugins.extras.lang.yaml`
What it adds:
- `yaml-language-server` with SchemaStore
- Validates `docker-compose.yml`, GitHub Actions workflows, Kubernetes manifests
- Useful for NestJS/Next.js project configs

#### `lazyvim.plugins.extras.test.core`
What it adds:
- `neotest` framework (see `06-testing.md` for jest/vitest adapter setup)
- Base testing infrastructure — you add the adapter on top

#### `lazyvim.plugins.extras.editor.harpoon2`
What it adds:
- Quick file bookmarking for the files you jump between constantly
- `<leader>h` to add, `<C-1>` through `<C-4>` to jump
- Invaluable when switching between `component.tsx`, `component.test.tsx`, and `*.module.ts`

### LOW priority

#### `lazyvim.plugins.extras.lang.docker`
What it adds:
- Dockerfile LSP + syntax highlighting
- docker-compose.yml LSP

#### `lazyvim.plugins.extras.editor.rest`
What it adds:
- REST client inside Neovim (see `07-new-plugins.md` for a more detailed alternative)

---

## After Enabling Extras

Run `:Lazy sync` to install any new plugins, then `:Mason` to verify all language servers
were installed. Some servers need Node.js in PATH — since you're a Node developer this should
already be fine.
