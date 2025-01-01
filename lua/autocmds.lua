require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
---------------------------------------------- TS TOOLS ----------------------------------------------
autocmd("BufWritePre", {
  pattern = "*.ts,*.tsx",
  callback = function()
    print "Testing Buf"
    vim.cmd "TSToolsOrganizeImports"
    vim.cmd "w"
  end,
})
