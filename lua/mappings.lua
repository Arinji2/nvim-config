require "nvchad.mappings"

local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })
map("i", "<C-s>", "<Esc>:w<CR>i", { desc = "Save file", noremap = true, silent = true })

-- Clipboard / File path copying
map("n", "<leader>cf", function()
  local path = vim.fn.expand "%"
  vim.fn.setreg("+", path)
  vim.notify("Copied relative path:\n" .. path)
end, { desc = "Copy relative path", noremap = true, silent = true })

map("n", "<leader>cF", function()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path:\n" .. path)
end, { desc = "Copy absolute path", noremap = true, silent = true })

-- Telescope
map("n", "<leader>fw", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "Telescope live grep (with args)" })

map("n", "<leader>fs", function()
  require("telescope.builtin").lsp_document_symbols { symbols = "function" }
end, { desc = "Find functions in current file" })

-- LSP / Code actions
map({ "n", "i" }, "<C-z>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help", noremap = true, silent = true })

map("n", "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { desc = "LSP Code Actions", noremap = true, silent = true })

map("n", "<leader>rn", function()
  require "inc_rename"
  return ":IncRename "
end, { desc = "Rename (manual input)", expr = true })

map("n", "<leader>rN", function()
  require "inc_rename"
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Rename (pre-filled word)", expr = true })

-- Buffer / Windows
map("n", "<leader>bb", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and not vim.bo[buf].modified then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = "Close all saved buffers" })

map("x", "<leader>d", "y'>o<Esc>p", {
  desc = "Duplicate selected text below",
  noremap = true,
  silent = true,
})

-- Formatting
map("n", "<leader>fp", function()
  require("scripts.prettier").format_with_tailwind()
end, { desc = "Format file with Tailwind" })

-- Terminal: ToggleTerm
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = nil

map({ "n", "t" }, "<A-g>", function()
  if not lazygit then
    lazygit = Terminal:new {
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "shadow",
        width = vim.o.columns,
        height = math.floor(vim.o.lines),
        winblend = 3,
      },
      on_close = function()
        vim.cmd "set cmdheight=1"
      end,
    }
  end

  if lazygit:is_open() then
    lazygit:close()
  else
    vim.o.cmdheight = 0
    lazygit:open()
  end
end, { desc = "Toggle LazyGit terminal", silent = true })

-- Generic terminal toggle
local term = Terminal:new { hidden = true }
map({ "n", "t" }, "<C-\\>", function()
  term:toggle()
end, { desc = "Toggle embedded terminal" })
