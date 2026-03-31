require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("BiomeLspAttach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "biome" then
      return
    end

    autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
      buffer = args.buf,
      callback = function()
        local encoding = client.offset_encoding or "utf-8"
        local params = vim.lsp.util.make_range_params(0, encoding)
        params.context = {
          only = { "source.fixAll.biome" },
          diagnostics = {},
        }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
        for _, res in pairs(result or {}) do
          for _, action in pairs(res.result or {}) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, encoding)
            end
            if action.command then
              vim.lsp.buf.execute_command(action.command)
            end
          end
        end
      end,
    })
  end,
})

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.mdx",
  command = "set filetype=markdown",
})
