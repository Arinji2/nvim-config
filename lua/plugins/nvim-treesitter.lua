return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = require("languages").treesitter,
  },
  highlight = {
    enable = true,
  },
  config = function()
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
  end,
}
