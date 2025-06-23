require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
---------------------------------------------- Markdown TOOLS ----------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "vtsls" then
      return
    end

    -- Buffer-local mapping (only for files where vtsls is active)
    vim.keymap.set("n", "<leader>lo", function()
      vim.lsp.buf.code_action {
        ---@diagnostic disable-next-line
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      }
    end, { buffer = args.buf, desc = "LSP: Organize Imports" })

    vim.keymap.set("n", "<leader>la", function()
      vim.lsp.buf.code_action {
        ---@diagnostic disable-next-line
        context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
        apply = true,
      }
    end, { buffer = args.buf, desc = "LSP: Add Missing Imports" })
  end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.mdx",
  command = "set filetype=markdown",
})
