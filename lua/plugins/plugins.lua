return {
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
    "famiu/bufdelete.nvim",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
}
