return {
  {
    "mluders/comfy-line-numbers.nvim",
  },
  {
    "neovim/nvim-lspconfig",
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
  {
    "folke/which-key.nvim",
    lazy = false,
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      map_cr = false, -- stop autopairs from mapping <BS>
    },
  },
}
