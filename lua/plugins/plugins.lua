return {
  {
    "rest-nvim/rest.nvim",
  },
  {
    "charlespascoe/vim-go-syntax",
    ft = "go",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
}
