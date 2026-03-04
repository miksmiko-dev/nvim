-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local gs = require("gitsigns")

-- Navigate hunks
vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Git: Next Hunk" })
vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Git: Prev Hunk" })

-- Stage / reset individual hunks (no need to leave Neovim)
vim.keymap.set("n", "<leader>ghs", gs.stage_hunk, { desc = "Git: Stage Hunk" })
vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { desc = "Git: Reset Hunk" })
vim.keymap.set("v", "<leader>ghs", function()
  gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Git: Stage Selected Hunks" })
vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "Git: Stage Buffer" })
vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Git: Reset Buffer" })

-- Preview
vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "Git: Preview Hunk" })
vim.keymap.set("n", "<leader>ghb", function()
  gs.blame_line({ full = true })
end, { desc = "Git: Blame Line (full)" })
