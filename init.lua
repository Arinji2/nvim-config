-- ==========================================
-- 1. GLOBALS
-- ==========================================
-- Set NvChad's theme cache path so it knows where to build colors
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

-- Set <Space> as the main trigger key for custom shortcuts
vim.g.mapleader = " "

-- ==========================================
-- 2. BOOTSTRAP PACKAGE MANAGER (LAZY.NVIM)
-- ==========================================
-- If lazy.nvim isn't installed, automatically clone it from GitHub
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================
-- 3. LOAD PLUGINS
-- ==========================================
local lazy_config = require "configs.lazy"

require("lazy").setup({
  -- Load NvChad core framework
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    -- Load base vim options right as NvChad boots up
    config = function()
      require "options"
    end,
  },

  -- Automatically load every file inside `lua/plugins/`
  { import = "plugins" },
}, lazy_config)

-- ==========================================
-- 4. LOAD THEME & CORE SETTINGS
-- ==========================================
-- Execute the cached NvChad theme files (much faster than requiring)
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load event listeners (e.g. format on save)
require "autocmds"

-- Load custom snippets (Go, JS, TSX)
require "snippets"

-- Defer loading keymaps so the UI renders instantly first
vim.schedule(function()
  require "mappings"
end)

-- Enable LSP inline variable hints globally (great for Go/TS)
vim.lsp.inlay_hint.enable(true)

-- ==========================================
-- 5. LSP UI OVERRIDES
-- ==========================================
-- Intercept Neovim's default LSP hover windows to force a "single" line border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "single"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
