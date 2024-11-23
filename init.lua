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
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/Projects", "~/Downloads" },
      -- log_level = 'debug',
      auto_restore_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
    },
    config = function(_, opts)
      require("auto-session").setup(opts)
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<C-q>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

require("nvim-tree").setup {
  update_cwd = true,
  git = {
    enable = true,
    ignore = false,
  },
  filters = {
    dotfiles = false,
  },
}

vim.opt.virtualedit = "onemore"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

vim.schedule(function()
  require "mappings"
end)
