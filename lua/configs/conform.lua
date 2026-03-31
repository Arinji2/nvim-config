local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    go = { "gofumpt", "goimports" },
    json = { "prettierd" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    markdown = { "prettierd" },
    sql = { "sqlfmt" },
    cpp = { "clang-format" },
    yaml = { "prettierd" },
  },

  formatters = {
    biome = {
      command = "biome",
      args = {
        "format",
        "--stdin-file-path",
        "$FILENAME",
      },
      stdin = true,
    },
  },

  format_on_save = {
    timeout_ms = 2500,
    lsp_fallback = false,
  },
}

return options
