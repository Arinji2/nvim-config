require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
---------------------------------------------- Markdown TOOLS ----------------------------------------------

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.mdx",
  command = "set filetype=markdown",
})

-- Open all folds
autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "silent! normal! zR"
  end,
})
