return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    -- Optional: remap Ctrl+D to visual-multi style
    vim.g.VM_maps = {
      ["Find Under"] = "<A-d>",
      ["Find Subword Under"] = "<A-d>",
      ["Select All"] = "<A-a>",
      ["Select Next"] = "<A-d>",
      ["Select Prev"] = "<A-p>",
      ["Exit"] = "<Esc>",
    }
  end,
}
