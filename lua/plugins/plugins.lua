return {
  {
    "neovim/nvim-lspconfig",
    dependencies = "pmizio/typescript-tools.nvim",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
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
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    opts = function(_, opts)
      local telescope = require "telescope"

      -- merge with NVChad's telescope config
      telescope.setup(opts)

      telescope.load_extension "live_grep_args"
    end,
  },
}
