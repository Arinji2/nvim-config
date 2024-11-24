require "nvchad.mappings"
-- add yours here
local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", function()
  require("conform").format { async = true, lsp_fallback = true }
  vim.cmd "w"
end, { desc = "Format and save file" })

vim.keymap.set("n", "<leader>g", function()
  -- Define the LazyGit terminal inside the function
  local Terminal = require("toggleterm.terminal").Terminal

  local lazygit = Terminal:new {
    cmd = "lazygit", -- Command to run inside the terminal
    hidden = true, -- Start the terminal hidden
    direction = "float", -- Set the terminal to open in a floating window
    float_opts = { -- Optional: Set options for floating window appearance
      border = "rounded", -- Rounded corners for the floating window
      width = 120, -- Width of the floating window
      height = 30, -- Height of the floating window
      winblend = 3, -- Transparency of the floating window
    },
  }

  -- Toggle the LazyGit terminal
  lazygit:toggle()
end, { noremap = true, silent = true, desc = "Toggle LazyGit terminal" })
