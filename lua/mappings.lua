require "nvchad.mappings"
-- add yours here
--
local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>fw", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "telescope live grep (args)" })
map("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true, silent = true })
map("x", "<leader>d", "y'>o<Esc>p", { noremap = true, silent = true, desc = "Duplicate selected, below cursor" })

map({ "n", "i" }, "<C-z>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
map("n", "<leader>fs", "<Cmd> lua require ('telescope.builtin').lsp_document_symbols({ symbols = 'function'})<CR>", {
  desc = "Find function",
})

map("n", "+", "<C-a>", { desc = "Increment numbers", noremap = true })
map("n", "-", "<C-x>", { desc = "Decrement numbers", noremap = true })

map("n", "<leader>cf", function()
  local path = vim.fn.expand "%"
  vim.fn.setreg("+", path)
  vim.notify("Copied relative path:\n" .. path)
end, { noremap = true, silent = true, desc = "Copy filename (Relative path)" })

map("n", "<leader>cF", function()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path:\n" .. path)
end, { noremap = true, silent = true, desc = "Copy filename (Absolute path)" })

vim.keymap.set("n", "<leader>bb", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and not vim.bo[buf].modified then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = "Close all saved buffers" })

map("n", "<leader>fp", function()
  require("scripts.prettier").format_with_tailwind()
end, { desc = "Format with tailwind" })

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
      on_close = function()
        vim.cmd "set cmdheight=1"
      end,
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

vim.keymap.set("n", "<leader>rn", function()
  require "inc_rename"
  return ":IncRename "
end, { desc = "Rename the word under cursor", expr = true })

vim.keymap.set("n", "<leader>rN", function()
  require "inc_rename"
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Rename the word under cursor (Fills Word)", expr = true })
