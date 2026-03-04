# 09 – AI Completions

## Important: Your Auth Method

You authenticated via **Gmail/Google OAuth** through `claude.ai/code`. This gives you the
`claude` CLI binary — it does **not** give you an Anthropic API key. These are two different
products:

| Product | Auth | Works with |
|---------|------|-----------|
| Claude Code (claude.ai/code) | Google/Gmail OAuth | `claude` CLI binary |
| Anthropic API | API key from console.anthropic.com | `ANTHROPIC_API_KEY` env var |

Since you have the CLI, you use Neovim plugins that **shell out to the `claude` binary**
instead of calling the API directly. Verify your CLI is working:

```sh
which claude    # should return a path
claude --version
```

---

## Option A — codecompanion.nvim with `claude_code` adapter (Recommended)

`codecompanion.nvim` has a built-in adapter that uses your `claude` CLI directly.
No API key needed — it uses the same session you already authenticated.

```lua
-- lua/plugins/ai.lua  (new file)
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      -- Use the claude CLI binary (OAuth session, no API key needed)
      strategies = {
        chat   = { adapter = "claude_code" },
        inline = { adapter = "claude_code" },
        agent  = { adapter = "claude_code" },
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
            width  = 0.35,
            border = "rounded",
          },
        },
        action_palette = {
          provider = "telescope",
        },
      },
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>",  desc = "AI: Chat Toggle",    mode = { "n", "v" } },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>",         desc = "AI: New Chat" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>",             desc = "AI: Inline Prompt",  mode = { "n", "v" } },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>",      desc = "AI: Action Palette", mode = { "n", "v" } },
      { "<leader>as", "<cmd>CodeCompanionChat Add<cr>",     desc = "AI: Add to Chat",    mode = "v" },
    },
  },
}
```

> **Note:** The `claude_code` adapter was added in codecompanion.nvim v11+. After installing,
> run `:Lazy update` then verify with `:CodeCompanionChat` that it opens a chat window.

---

## Option B — avante.nvim (Copilot-style sidebar, uses `claude` CLI)

`avante.nvim` is a more polished AI sidebar experience, similar to Cursor's AI panel.
It also supports the `claude_code` provider (CLI-based, no API key).

```lua
-- lua/plugins/ai.lua  (new file)
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      provider = "claude_code",        -- Uses the `claude` CLI binary
      claude_code = {
        model      = "claude-sonnet-4-6",  -- or "claude-opus-4-6"
        timeout    = 30000,
        extra_curl_args = {},
      },
      behaviour = {
        auto_suggestions    = false,   -- Don't auto-suggest (trigger manually)
        auto_set_highlight_group = true,
        auto_set_keymaps    = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },
      windows = {
        position     = "right",
        wrap         = true,
        width        = 35,
        sidebar_header = {
          align  = "center",
          rounded = true,
        },
      },
      diff = {
        autojump        = false,
        list_opener     = "copen",
      },
      hints = { enabled = true },
    },
    keys = {
      { "<leader>aa", "<cmd>AvanteAsk<cr>",     desc = "AI: Ask Avante",    mode = { "n", "v" } },
      { "<leader>ac", "<cmd>AvanteChat<cr>",    desc = "AI: Avante Chat" },
      { "<leader>ae", "<cmd>AvanteEdit<cr>",    desc = "AI: Edit Selection", mode = "v" },
      { "<leader>at", "<cmd>AvanteToggle<cr>",  desc = "AI: Toggle Sidebar" },
      { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "AI: Refresh" },
    },
  },
}
```

**avante.nvim workflow:**
- `<leader>aa` — ask a question (opens sidebar with Claude's response)
- Visual select code → `<leader>ae` — ask Claude to edit the selection
- Claude proposes a diff → you accept/reject hunks like a git diff

---

## Comparison

| Plugin | Auth needed | UX style | Code editing |
|--------|-------------|----------|-------------|
| `codecompanion.nvim` | `claude` CLI (your setup) | Chat panel | Inline + chat |
| `avante.nvim` | `claude` CLI (your setup) | Sidebar + diff | Diff-based |

Both work with your existing Gmail-authenticated `claude` CLI.

**If you want chat-style:** use `codecompanion.nvim`
**If you want Cursor-style diff editing:** use `avante.nvim`
You can also install both — they use different keybinding prefixes.

---

## Adding Ghost-Text Inline Completions

Neither plugin above provides Copilot-style tab-complete ghost text. If you want that:

### Supermaven (free, fastest)
```lua
-- Add to lua/plugins/ai.lua
{
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  opts = {
    keymaps = {
      accept_suggestion = "<M-l>",   -- Alt+l to accept
      accept_word       = "<M-w>",
      clear_suggestion  = "<C-]>",
    },
    color = { suggestion_color = "#555555" },
    log_level = "off",
  },
},
```

### Codeium (free, also good)
Enable via `:LazyExtras` → `lazyvim.plugins.extras.ai.codeium`

---

## Recommended Setup for Your Situation

```
avante.nvim          →  Cursor-style diff editing with Claude (your existing auth)
  +
Supermaven           →  Free ghost-text tab completions
```

This costs nothing extra beyond your current Claude Code subscription.
