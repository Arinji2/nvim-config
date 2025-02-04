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

lspconfig.sqlls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql" },
  root_dir = lspconfig.util.root_pattern ".",
}

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
require("typescript-tools").setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList" },
      emmetCompletions = true,
      hovers = true,
      suggestions = true,
    },
  },
}

-- C++ language server (Clangd)
lspconfig.clangd.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  -- You can add extra clangd-specific settings here if needed.
}
