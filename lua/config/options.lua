-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Use Astral ty as the Python language server.
vim.g.lazyvim_python_lsp = "ty"

-- Providers
vim.g.python3_host_prog = vim.fn.expand("~/.venv/neovim/bin/python3")
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
