require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
---------------------------------------------- Markdown TOOLS ----------------------------------------------

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.mdx",
  command = "set filetype=markdown",
})

-- Open all folds
autocmd({ "BufReadPost", "FileReadPost" }, {
  callback = function()
    vim.cmd "normal zR"
  end,
})
