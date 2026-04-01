local nvlsp = require "nvchad.configs.lspconfig"
local servers = require("languages").lsp_servers

-- Load NvChad's defaults
nvlsp.defaults()

-- 1. Define custom settings for specific servers
local server_configs = {
  gopls = {
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
      },
    },
  },

  tailwindcss = {
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "classList" },
        emmetCompletions = true,
        hovers = true,
        suggestions = true,
      },
    },
  },

  vtsls = {
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    settings = {
      typescript = {
        format = { enable = false },
        suggest = { completeFunctionCalls = true },
      },
      javascript = {
        format = { enable = false },
        suggest = { completeFunctionCalls = true },
      },
      vtsls = {
        experimental = { enableProjectDiagnostics = true },
      },
    },
  },
  eslint = {
    settings = {
      codeActionOnSave = {
        enable = true,
        mode = "all",
      },
      workingDirectory = { mode = "auto" },
    },
  },
}

for _, name in ipairs(servers) do
  local opts = server_configs[name] or {}

  -- CRITICAL: Inject NvChad's capabilities so autocompletion works!
  opts.capabilities = nvlsp.capabilities

  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
