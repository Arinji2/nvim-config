return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = require("languages").treesitter,
  },
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },
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
