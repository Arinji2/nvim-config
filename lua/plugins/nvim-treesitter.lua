return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = require("languages").treesitter,
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
          },
        },
      }
    end,
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      update_cwd = true,
      filesystem_watchers = {
        enable = true,
        ignore_dirs = { ".next", "node_modules", "dist", "build" },
      },
      update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = { "help" },
      },
      view = {
        relativenumber = true,
        adaptive_size = true,
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
          enable = true,
          icons = { corner = "└ ", edge = "│ ", item = "│ ", none = "  " },
        },
      },
      git = { enable = true, ignore = false },
      filters = { dotfiles = false },
    },
  },
}
