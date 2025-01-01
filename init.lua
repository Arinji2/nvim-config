vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  require "plugins.inline-diagnostics",
  require "plugins.nvim-treesitter",
  require "plugins.git-signs",
  require "plugins.conform",
  require "plugins.toggle-term",
  require "plugins.auto-session",
  require "plugins.supermaven",
  require "plugins.trouble",
  require "plugins.lazygit",
  require "plugins.rename",
  require "plugins.hardtime",
  require "plugins.multicursors",
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "v",
      node_decremental = "<C-v>",
    },
  },
}
require "options"
require "autocmds"

require("treesitter-context").setup {
  max_lines = 1,
  trim_scope = "inner",
}
vim.schedule(function()
  require "mappings"
end)
