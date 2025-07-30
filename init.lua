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
vim.lsp.inlay_hint.enable(true)

require "snippets"

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "single"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

require("oil").setup()

require("comfy-line-numbers").setup {
  labels = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "11",
    "12",
    "13",
    "14",
    "15",
    "21",
    "22",
    "23",
    "24",
    "25",
    "31",
    "32",
    "33",
    "34",
    "35",
    "41",
    "42",
    "43",
    "44",
    "45",
    "51",
    "52",
    "53",
    "54",
    "55",
    "111",
    "112",
    "113",
    "114",
    "115",
    "121",
    "122",
    "123",
    "124",
    "125",
    "131",
    "132",
    "133",
    "134",
    "135",
    "141",
    "142",
    "143",
    "144",
    "145",
    "151",
    "152",
    "153",
    "154",
    "155",
    "211",
    "212",
    "213",
    "214",
    "215",
    "221",
    "222",
    "223",
    "224",
    "225",
    "231",
    "232",
    "233",
    "234",
    "235",
    "241",
    "242",
    "243",
    "244",
    "245",
    "251",
    "252",
    "253",
    "254",
    "255",
  },
  up_key = "k",
  down_key = "j",

  hidden_file_types = { "undotree" },
  hidden_buffer_types = { "terminal" },
}
