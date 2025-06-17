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
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = { "help" },
      },
      view = {
        relativenumber = true,
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
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
          },
        },
      },
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
