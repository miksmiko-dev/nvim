# 08 – Git Workflow Improvements

## Current State

You have `gitsigns.nvim` with inline blame (good). Missing: a way to view diffs properly,
stage hunks visually, and navigate complex merge conflicts.

---

## Diffview.nvim — Visual Diff and Merge Tool

The most useful git addition for any serious project. Gives you a side-by-side diff viewer,
a file history browser, and a 3-way merge conflict resolver.

```lua
-- lua/plugins/git.lua  (new file)
return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewToggleFiles",
    },
    keys = {
      { "<leader>gd",  "<cmd>DiffviewOpen<cr>",                desc = "Git: Diff View" },
      { "<leader>gD",  "<cmd>DiffviewClose<cr>",               desc = "Git: Close Diff View" },
      { "<leader>gfh", "<cmd>DiffviewFileHistory %<cr>",       desc = "Git: File History" },
      { "<leader>gFh", "<cmd>DiffviewFileHistory<cr>",         desc = "Git: Repo History" },
      { "<leader>gm",  "<cmd>DiffviewOpen HEAD...origin/main<cr>", desc = "Git: Diff vs main" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",  -- Side-by-side
          winbar_info = true,
        },
        merge_tool = {
          layout = "diff3_mixed",        -- 3-way merge view
          disable_diagnostics = true,
        },
      },
      file_panel = {
        listing_style = "tree",
        win_config = {
          position = "left",
          width = 35,
        },
      },
    },
  },
}
```

**Workflows:**
- `<leader>gd` — open diff for all changed files (like `git diff`)
- `<leader>gfh` — see every commit that touched the current file
- `<leader>gm` — compare current branch to `main` (great for PR review)
- On merge conflict: `:DiffviewOpen` shows the 3-way merge view automatically

**Inside Diffview:**
- `Tab` / `S-Tab` — navigate between changed files
- `[x` / `]x` — jump between conflict markers
- `<leader>co` — choose ours (left), `<leader>ct` — choose theirs (right)
- `q` — close diffview

---

## Option A: Neogit (Magit-style)

If you like Emacs Magit-style git, Neogit is the closest thing for Neovim:

```lua
-- Add to lua/plugins/git.lua
{
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",    -- Integrates with diffview for better diffs
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>gg", function() require("neogit").open() end, desc = "Git: Neogit" },
  },
  opts = {
    integrations = {
      diffview  = true,   -- Use diffview for diffs
      telescope = true,   -- Use telescope for branch picker
    },
    graph_style = "unicode",
    signs = {
      hunk = { "", "" },
      item = { ">", "v" },
      section = { ">", "v" },
    },
  },
},
```

---

## Option B: Lazygit (Terminal-based)

If you prefer Lazygit (a full TUI), it integrates seamlessly with your existing Toggleterm:

Add a dedicated keybinding in `lua/config/keymaps.lua`:

```lua
-- Open lazygit in a floating terminal
vim.keymap.set("n", "<leader>gl", function()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = vim.fn.getcwd(),
    direction = "float",
    float_opts = {
      border = "curved",
      width = function() return math.floor(vim.o.columns * 0.95) end,
      height = function() return math.floor(vim.o.lines * 0.95) end,
    },
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<Cmd>close<CR>", { noremap = true, silent = true })
    end,
  })
  lazygit:toggle()
end, { desc = "Git: Lazygit" })
```

Requires `lazygit` to be installed on your system:
```sh
# Ubuntu/Debian
sudo apt install lazygit
# or via Go
go install github.com/jesseduffield/lazygit@latest
```

---

## Enhanced Gitsigns Keybindings

Your current `gitsign.lua` doesn't define keybindings — it relies on LazyVim defaults.
Add these to `lua/config/keymaps.lua` for a more complete git hunk workflow:

```lua
local gs = require("gitsigns")

-- Navigate hunks
vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Git: Next Hunk" })
vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Git: Prev Hunk" })

-- Stage / reset individual hunks (no need to leave Neovim)
vim.keymap.set("n", "<leader>ghs", gs.stage_hunk,        { desc = "Git: Stage Hunk" })
vim.keymap.set("n", "<leader>ghr", gs.reset_hunk,        { desc = "Git: Reset Hunk" })
vim.keymap.set("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git: Stage Selected Hunks" })
vim.keymap.set("n", "<leader>ghS", gs.stage_buffer,      { desc = "Git: Stage Buffer" })
vim.keymap.set("n", "<leader>ghR", gs.reset_buffer,      { desc = "Git: Reset Buffer" })

-- Preview
vim.keymap.set("n", "<leader>ghp", gs.preview_hunk,      { desc = "Git: Preview Hunk" })
vim.keymap.set("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Git: Blame Line (full)" })
```

> These complement your existing `<leader>g` → Neo-tree git status. Now you have:
> - `<leader>g` — visual git status tree
> - `<leader>gd` — full diff view (with diffview.nvim)
> - `<leader>gg` or `<leader>gl` — Neogit or Lazygit
> - `]h`/`[h` — navigate hunks inline
