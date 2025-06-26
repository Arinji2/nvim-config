return {
  "rareitems/printer.nvim",
  lazy = false,
  config = function()
    require("printer").setup {
      keymap = "gp",
    }
  end,
}
