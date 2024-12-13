require "nvchad.mappings"
-- add yours here
local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true, silent = true })

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = nil

vim.keymap.set({ "n", "t" }, "<A-g>", function()
  if not lazygit then
    -- Create the LazyGit terminal if it doesn't exist
    lazygit = Terminal:new {
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "shadow",
        width = vim.o.columns,
        height = math.floor(vim.o.lines * 1),
        winblend = 3,
      },
    }
  end

  -- Check if the terminal is currently open and toggle accordingly
  if lazygit:is_open() then
    lazygit:close()
  else
    vim.o.cmdheight = 0
    lazygit:open()
  end
end, { silent = true, desc = "Toggle LazyGit terminal" })
-- Create a terminal instance
local term = Terminal:new {
  hidden = true, -- Start hidden
}

-- Function to toggle the current terminal
local function toggle_current_terminal()
  term:toggle()
end

-- Keymaps for toggling and creating terminals
map({ "n", "t" }, "<C-\\>", toggle_current_terminal, { desc = "Toggle the current terminal" })
