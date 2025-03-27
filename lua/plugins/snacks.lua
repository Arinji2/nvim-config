return {
  "folke/snacks.nvim",
  lazy = false,
  config = function()
    -- Define custom highlight groups before setup
    vim.api.nvim_set_hl(0, "SnacksIndentCustom2", { fg = "#444444" }) -- Inactive indent color
    vim.api.nvim_set_hl(0, "SnacksIndentCustom3", { fg = "#555555" }) -- Alternative inactive indent color
    vim.api.nvim_set_hl(0, "SnacksIndentCustom", { fg = "#ffffff", bold = true }) -- Scope indent color

    require("snacks").setup {
      terminal = {
        enabled = false,
      },
      indent = {
        enabled = true,
        char = "▎",
        animate = { enabled = false },
        indent = {
          only_current = true,
          only_scope = false,
        },
        scope = {
          enabled = true,
          only_current = true,
          only_scope = true,
          underline = false,
        },
        chunk = {
          enabled = true,
          only_current = true,
        },
        -- filter for buffers, turn off the indents for markdown
        filter = function(buf)
          return vim.g.snacks_indent ~= false
            and vim.b[buf].snacks_indent ~= false
            and vim.bo[buf].buftype == ""
            and vim.bo[buf].filetype ~= "markdown"
        end,
      },
      scroll = {
        enabled = false,
      },
      window_picker = { enabled = false },
      ui = { enabled = false },
      filetree = { enabled = false },
    }
  end,
}
