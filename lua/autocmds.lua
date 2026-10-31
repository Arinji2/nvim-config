require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- 1. Run Code Actions on Save (Organize Imports & Fix All)
autocmd("BufWritePre", {
  group = augroup("LspCodeActionsOnSave", { clear = true }),
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.go" },
  callback = function(args)
    local bufnr = args.buf
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    -- Case 1: Biome is active (handles both imports and fixes exclusively)
    local biome = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })[1]
    if biome then
      local params = vim.lsp.util.make_range_params(0, "utf-16")
      params.context = {
        diagnostics = {},
        only = { "source.organizeImports.biome", "source.fixAll.biome" },
      }
      local res = biome:request_sync("textDocument/codeAction", params, 2000, bufnr)
      for _, r in ipairs((res and res.result) or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, biome.offset_encoding or "utf-16")
        end
      end
      return
    end

    -- Case 2: TypeScript / JavaScript via vtsls
    -- 'typescript.organizeImports' is a single atomic pass:
    -- it removes unused imports AND sorts remaining ones without corrupting lines.
    local vtsls = vim.lsp.get_clients({ bufnr = bufnr, name = "vtsls" })[1]
    if vtsls then
      vtsls:request_sync("workspace/executeCommand", {
        command = "typescript.organizeImports",
        arguments = { bufname },
      }, 2000, bufnr)
    end

    -- Case 3: ESLint (runs safe autofixes like semi, quotes, etc.)
    local eslint = vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })[1]
    if eslint then
      local params = vim.lsp.util.make_range_params(0, "utf-16")
      params.context = {
        diagnostics = {},
        only = { "source.fixAll.eslint" },
      }
      local res = eslint:request_sync("textDocument/codeAction", params, 2000, bufnr)
      for _, r in ipairs((res and res.result) or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, eslint.offset_encoding or "utf-16")
        end
      end
    end

    -- Case 4: Go via gopls
    local gopls = vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" })[1]
    if gopls then
      local params = vim.lsp.util.make_range_params(0, "utf-16")
      params.context = {
        diagnostics = {},
        only = { "source.organizeImports" },
      }
      local res = gopls:request_sync("textDocument/codeAction", params, 2000, bufnr)
      for _, r in ipairs((res and res.result) or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, gopls.offset_encoding or "utf-16")
        end
      end
    end
  end,
})

-- 2. Force MDX files to use Markdown highlighting
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.mdx",
  command = "set filetype=markdown",
})
