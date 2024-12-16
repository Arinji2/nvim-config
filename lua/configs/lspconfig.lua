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

-- Extend vtsls configuration with eslint auto-fix on save
lspconfig.vtsls.setup {
  on_attach = function(client, bufnr)
    -- Extend the default NvChad on_attach
    require("nvchad.configs.lspconfig").on_attach(client, bufnr)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        -- Get current diagnostics
        local diagnostics = vim.diagnostic.get(bufnr)

        -- Check if there are any diagnostics
        print(#diagnostics)
        if #diagnostics > 0 then
          -- Run eslint --fix only if there are issues
          vim.cmd "silent! !eslint --fix %"

          -- Organize imports only if there are diagnostics
          vim.lsp.buf.code_action {
            context = {
              diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
              only = {
                "source.organizeImports",
              },
            },
            apply = true,
          }
        end
      end,
      group = vim.api.nvim_create_augroup("VTslsAutoFix", { clear = true }),
      desc = "Auto-fix VTSLS issues on save only if diagnostics exist",
    })
  end,
  on_init = require("nvchad.configs.lspconfig").on_init,
  capabilities = require("nvchad.configs.lspconfig").capabilities,
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifier = "non-relative",
      },
    },
    javascript = {
      preferences = {
        importModuleSpecifier = "non-relative",
      },
    },
  },
}
