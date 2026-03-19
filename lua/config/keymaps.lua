-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- System clipboard
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- Visual mode quality-of-life
map("x", "p", '"_dP', { desc = "Paste without replacing yank register" })
map("x", ">", ">gv", { desc = "Indent and keep selection" })
map("x", "<", "<gv", { desc = "Outdent and keep selection" })
map("n", "<leader>v", "gv", { desc = "Reselect previous visual selection" })
