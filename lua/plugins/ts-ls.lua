return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    local api = require "typescript-tools.api"
    require("typescript-tools").setup {
      handlers = {
        ["textDocument/publishDiagnostics"] = api.filter_diagnostics { 6133 },
      },
      settings = {
        tsserver_file_preferences = {
          importModuleSpecifierPreference = "non-relative",
        },
      },
    }
    -- local autocmd = vim.api.nvim_create_autocmd
    -- autocmd("BufWritePre", {
    --   pattern = "*.ts,*.tsx,*.jsx,*.js",
    --   callback = function(args)
    --     vim.cmd "silent! undojoin | TSToolsAddMissingImports sync"
    --     vim.cmd "silent! undojoin | TSToolsOrganizeImports sync"
    --     require("conform").format { bufnr = args.buf }
    --   end,
    -- })
    local keymap = vim.keymap.set
    keymap("n", "<leader>lc", ":TSToolsRemoveUnused<CR>", { desc = "Remove unused code" })
    keymap("n", "<leader>lf", ":TSToolsFixAll<CR>", { desc = "Fix all fixable errors" })
  end,
}
