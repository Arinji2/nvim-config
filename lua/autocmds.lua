require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
---------------------------------------------- Markdown TOOLS ----------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    if client.name == "biome" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
        callback = function()
          vim.lsp.buf.code_action {
            context = {
              ---@diagnostic disable-next-line: assign-type-mismatch
              only = { "source.fixAll.biome" },
              diagnostics = {},
            },
            apply = true,
          }
        end,
      })
    end
  end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.mdx",
  command = "set filetype=markdown",
})
