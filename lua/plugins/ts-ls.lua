return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    local api = require "typescript-tools.api"
    require("typescript-tools").setup {
      handlers = {
        ["textDocument/publishDiagnostics"] = api.filter_diagnostics { 6133, 6196 },
      },
      settings = {
        tsserver_file_preferences = {
          importModuleSpecifierPreference = "shortest",
          importModuleSpecifierEnding = "auto",

          -- reasonable inlay hints
          includeInlayParameterNameHints = "literals",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
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
    keymap("n", "<leader>lf", ":TSToolsFixAll<CR>", { desc = "Fix all fixable issues" })
    keymap("n", "<leader>lo", ":TSToolsOrganizeImports<CR>", { desc = "Organize imports" })
    keymap("n", "<leader>li", ":TSToolsAddMissingImports<CR>", { desc = "Add missing imports" })
    keymap("n", "<leader>lu", ":TSToolsRemoveUnused<CR>", { desc = "Remove unused code" })
    keymap("n", "<leader>lR", ":TSToolsRenameFile<CR>", { desc = "Rename file + update imports" })
  end,
}
