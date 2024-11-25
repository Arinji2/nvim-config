require "nvchad.mappings"
-- add yours here
local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "ff", "<cmd>Telescope find_files<CR>")
map("n", "fg", "<cmd>Telescope live_grep<CR>")
