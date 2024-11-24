require "nvchad.mappings"
-- add yours here
local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", function()
  require("conform").format { async = true, lsp_fallback = true }
  vim.cmd "w"
end, { desc = "Format and save file" })

