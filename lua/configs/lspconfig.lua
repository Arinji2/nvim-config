-- Load defaults (e.g., lua_lsp)
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- List of LSP servers with default configurations
local servers = require("languages").lsp_servers
local nvlsp = require "nvchad.configs.lspconfig"

-- Setup LSP servers with default configs
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- GO language server
lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

local jsonCapabilities = vim.lsp.protocol.make_client_capabilities()
jsonCapabilities.textDocument.completion.completionItem.snippetSupport = true
-- JSON language server
lspconfig.jsonls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = jsonCapabilities,
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json" },
}

lspconfig.tailwindcss.setup {
  on_attach = function(client, bufnr)
    -- Disable semantic tokens to prevent Tailwind from taking priority
    client.server_capabilities.semanticTokensProvider = nil

    -- Call your existing on_attach function if needed
    if nvlsp.on_attach then
      nvlsp.on_attach(client, bufnr)
    end
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    tailwindCSS = {

      classAttributes = { "class", "className", "classList" },
      emmetCompletions = true,
      hovers = true,
      suggestions = true,
      -- Uncomment if needed for shadcn UI
      -- experimental = {
      --   classRegex = {
      --     [["([^"]*)"]],
      --     [[`([^`]*)`]],
      --     [=[['"]([-\w\d]+)['"]\s*:\s*"([^"]*)"]=],
      --   },
      -- },
    },
  },
}

-- C++ language server (Clangd)
lspconfig.clangd.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Eslint language server
-- lspconfig.eslint.setup {
--   cmd = { "eslint" },
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   settings = {
--     workingDirectory = { mode = "auto" },
--   },
--   root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js", "package.json", ".git"),
-- }
lspconfig.vtsls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    typescript = {
      format = {
        enable = true,
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    javascript = {
      format = {
        enable = true,
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    vtsls = {
      experimental = {
        enableProjectDiagnostics = true, -- enables diagnostics across multiple TS projects
      },
    },
  },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
}
