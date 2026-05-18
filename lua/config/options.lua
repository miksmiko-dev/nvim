-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.scrolloff = 8 -- more context lines (LazyVim default is 4)
-- vim.opt.colorcolumn = "120" -- matches stylua.toml column width
vim.opt.clipboard = "unnamedplus" -- system clipboard
vim.opt.splitkeep = "screen" -- prevent text jumping when opening splits
vim.opt.pumheight = 10 -- cap completion popup to 10 items

-- vim.opt.relativenumber = false
-- vim.opt.statuscolumn = "%s%=%{v:lnum==line('.')?v:lnum:' '} "
