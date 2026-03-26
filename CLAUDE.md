# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built on [LazyVim](https://lazyvim.github.io/). LazyVim provides the plugin management framework and sensible defaults; this config extends and overrides those defaults.

## Code Style

Lua files are formatted with **stylua**: 2-space indentation, 120-character column width (see `stylua.toml`). Run formatting with:

```sh
stylua lua/
```

## Architecture

### Directory Structure

- `init.lua` — entry point; bootstraps lazy.nvim and loads `config.lazy`
- `lua/config/` — core Neovim config (loaded automatically by LazyVim):
  - `lazy.lua` — plugin manager setup; imports `lazyvim.plugins` then `plugins/`
  - `options.lua` — vim options (autoformat enabled)
  - `keymaps.lua` — custom keymaps (currently empty, uses LazyVim defaults)
  - `autocmds.lua` — custom autocommands (currently empty)
- `lua/plugins/` — each file returns a plugin spec table that **overrides or extends** LazyVim defaults
- `lazy-lock.json` — lockfile for pinned plugin versions
- `lazyvim.json` — LazyVim extras/presets configuration

### Plugin Override Pattern

Every file in `lua/plugins/` is auto-imported by lazy.nvim. To override a LazyVim plugin, return a spec with the same plugin name and use `opts` to merge settings:

```lua
return {
  "plugin/name",
  opts = function(_, opts)
    -- merge into existing opts
    opts.some_key = "value"
    return opts
  end,
}
```

To disable a LazyVim plugin: `{ "plugin/name", enabled = false }`.

### Key Custom Plugins & Their Roles

| File | Plugin | Purpose |
|------|--------|---------|
| `color-scheme.lua` | `github-nvim-theme` | Active colorscheme: `github_dark`, transparent bg |
| `dap.lua` | `nvim-dap` + `vscode-js-debug` | JS/TS/Node/Chrome debugging; reads `.vscode/launch.json` |
| `toggleterm.lua` | `toggleterm.nvim` | Floating terminal (zsh --login, 80% size) |
| `neo-tree.lua` | `neo-tree.nvim` | Floating file/buffer/git explorer (80%×60%); also configures snacks.nvim notifications |
| `telescope.lua` | `telescope.nvim` | File finder; ignores `node_modules`/`.git`; live_grep includes hidden files |
| `lazydev.lua` | `lazydev.nvim` | Lua LSP completions for Neovim API (ft=lua only) |
| `typescript.lua` | `nvim-lspconfig` + `typescript.nvim` | TypeScript/JavaScript LSP |
| `lua-snippet.lua` | `LuaSnip` | Snippets with VSCode-compatible snippet loading |
| `surround.lua` | `mini.surround` | `gsa`=add, `gsd`=delete, `gsr`=replace surrounding |
| `accelerated.lua` | `accelerated-jk.nvim` | Accelerating `j`/`k` movement |
| `smear-cursor.lua` | `smear-cursor.nvim` | Animated cursor trail |
| `auto-tag.lua` | `nvim-ts-autotag` | Auto-close/rename HTML/JSX tags |
| `disable-line.lua` | `indent-blankline.nvim` | Indent guides (│ character, muted gray) |
| `gitsign.lua` | `gitsigns.nvim` | Git signs + inline blame enabled |
| `todo.lua` | `todo-comments.nvim` | Highlight TODO/FIXME comments |
| `diffview.lua` | `diffview.nvim` | Git diff/history viewer (horizontal split, merge tool) |
| `spectre.lua` | `nvim-spectre` | Project-wide find & replace |
| `colorizer.lua` | `nvim-colorizer.lua` | Inline color previews; Tailwind class colors enabled |
| `snack-image.lua` | `snacks.nvim` | Inline image rendering (WezTerm); centered, max 40×12 |
| `lsp.lua` | `nvim-lspconfig` | Disables phpactor LSP server |

### Custom Keybindings

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal (float) |
| `<leader>1` | Terminal #2 |
| `<leader>R` | Open floating terminal |
| `<leader>F` | Neo-tree filesystem (floating, reveals current file) |
| `<leader>b` | Neo-tree buffers |
| `<leader>g` | Neo-tree git status |
| `<leader>tf` | Search TODOs with Telescope |
| `<leader>da` | DAP: continue (auto-loads `.vscode/launch.json` if present) |
| `<leader>dO` | DAP: step out |
| `<leader>do` | DAP: step over |
| `<leader>gd` | Diffview: open diff |
| `<leader>gh` | Diffview: current file history |
| `<leader>gH` | Diffview: repo history |
| `<leader>gq` | Diffview: close |
| `<leader>sr` | Spectre: project find & replace |
| `<leader>sw` | Spectre: search word under cursor |
| `<leader>sf` | Spectre: find & replace in current file |

All other keybindings come from LazyVim defaults.

## Adding a New Plugin

Create a new file in `lua/plugins/` returning a lazy.nvim spec table. It will be auto-loaded. Use the `example.lua` file as a reference template.

## DAP (Debugging) Notes

The JS/TS debugger adapter (`vscode-js-debug`) must be built after install — lazy.nvim handles this via the `build` key in `dap.lua`. Supported debug targets: Node.js (launch/attach) and Chrome. If a project has `.vscode/launch.json`, `<leader>da` will load those configs automatically.
