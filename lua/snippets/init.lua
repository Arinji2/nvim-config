local ls = require "luasnip"

-- Load all custom filetype snippets
require "snippets.javascript"
require "snippets.go"
require "snippets.typescriptreact"

-- Optionally, lazy-load VSCode style friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Optionally, enable autosnippets
ls.config.set_config {
  enable_autosnippets = true,
}
