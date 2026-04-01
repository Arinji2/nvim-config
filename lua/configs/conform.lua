-- Helper function to detect if we are in a Biome project
local function js_formatters(bufnr)
  -- Look upward from the current file for a biome config
  local has_biome = vim.fs.find({ "biome.json", "biome.jsonc" }, {
    upward = true,
    path = vim.api.nvim_buf_get_name(bufnr),
  })[1]

  if has_biome then
    return { "biome" }
  end

  -- Fallback to prettierd for ESLint/Prettier projects
  return { "prettierd" }
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    go = { "gofumpt", "goimports" },
    json = { "prettierd" },
    markdown = { "prettierd" },
    sql = { "sqlfmt" },
    cpp = { "clang-format" },
    yaml = { "prettierd" },

    -- Use our smart function for all JS/TS files!
    javascript = js_formatters,
    javascriptreact = js_formatters,
    typescript = js_formatters,
    typescriptreact = js_formatters,
  },

  formatters = {
    biome = {
      command = "biome",
      args = { "format", "--stdin-file-path", "$FILENAME" },
      stdin = true,
    },
  },

  format_on_save = {
    timeout_ms = 2500,
    lsp_fallback = false,
  },
}

return options
