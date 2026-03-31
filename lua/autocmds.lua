require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- 1. Run Code Actions on Save (Organize Imports & Fix All)
-- This synchronously asks the LSP to fix safe lints (Biome) and organize imports (Go/TS)
autocmd("BufWritePre", {
  group = augroup("LspCodeActionsOnSave", { clear = true }),
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.go" },
  callback = function(args)
    -- Provide window ID (0) and offset encoding to satisfy Neovim 0.11
    local params = vim.lsp.util.make_range_params(0, "utf-16")

    -- Tell the language server to treat this as a CodeAction object
    ---@cast params lsp.CodeActionParams
    params.context = {
      diagnostics = {},
      only = { "source.fixAll", "source.organizeImports" },
    }

    -- Request synchronously so it finishes BEFORE the file saves
    local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 2000)

    for cid, res in pairs(result or {}) do
      -- 1. Get the specific client that returned the code action
      local client = vim.lsp.get_clients({ id = cid })[1]
      if not client then
        return
      end

      for _, r in pairs(res.result or {}) do
        -- 2. If it's a text edit (like Biome formatting), apply it
        if r.edit then
          local enc = client.offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end

        -- 3. If it's a command, tell the client directly to execute it
        if r.command then
          local cmd = type(r.command) == "string" and { command = r.command, arguments = {} } or r.command
          client:request("workspace/executeCommand", cmd, nil, args.buf)
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
